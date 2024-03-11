//
//  AppCoordinator.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 10.03.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    override func start() {
        UserStorage.onboardingShown
            ? showMainFlow()
            : showOnboardingFlow()
    }

    override func finish() {
        print("AppCoordinator Finish")
    }
}

// MARK: - Navigation Methods

private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return }
        OnboardingFactory.createOnboardingFlow(
            coordinator: self,
            navigationController: navigationController,
            finishDelegate: self
        )
    }

    func showMainFlow() {
        guard let navigationController = navigationController else { return }
        let tabBarController = MainFactory.createMainFlow(
            coordinator: self,
            navigationController: navigationController,
            finishDelegate: self
        )

        navigationController.pushViewController(tabBarController, animated: true)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        removeChildCoordinator(childCoordinator)
        switch childCoordinator.type {
            case .app:
                return

            case .onboarding:
                navigationController?.viewControllers.removeAll()
                showMainFlow()

            default:
                navigationController?.popToRootViewController(animated: false)
        }
    }
}

extension AppCoordinator {
    convenience init(
        childCoordinators: [CoordinatorProtocol] = [CoordinatorProtocol](),
        navigationController: UINavigationController? = nil,
        finishDelegate: CoordinatorFinishDelegate? = nil
    ) {
        self.init(
            type: .app,
            childCoordinators: childCoordinators,
            navigationController: navigationController,
            finishDelegate: finishDelegate
        )
    }
}
