//
//  AppCoordinator.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 10.03.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    override func start() {
        showOnboardingFlow()
    }

    override func finish() {
        print("AppCoordinator Finish")
    }
}

// MARK: - Navigation Methods

private extension AppCoordinator {
    func showOnboardingFlow() {
        guard let navigationController = navigationController else { return }
        let onboardingCoordinator = OnboardingCoordinator(
            navigationController: navigationController,
            finishDelegate: self
        )
        addChildCoordinator(onboardingCoordinator)
        onboardingCoordinator.start()
    }

    func showMainFlow() {}
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        removeChildCoordinator(childCoordinator)
        switch childCoordinator.type {
            case .app:
                return

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
