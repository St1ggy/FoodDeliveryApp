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

    func createNavigationController(
        tabTitle: String,
        imageName: String,
        tag: Int
    ) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: tabTitle,
            image: UIImage(systemName: imageName),
            tag: tag
        )

        return navigationController
    }

    func configCoordinator(
        _ coordinator: Coordinator,
        navigationController: UINavigationController
    ) {
        coordinator.navigationController = navigationController
        coordinator.finishDelegate = self
        coordinator.start()

        addChildCoordinator(coordinator)
    }

    func showMainFlow() {
        guard let navigationController = navigationController else { return }

        let configs: [(Coordinator, String, String)] = [
            (HomeCoordinator(), "Home", "house"),
            (OrderCoordinator(), "Order", "cart"),
            (ListCoordinator(), "List", "list.dash"),
            (ProfileCoordinator(), "Profile", "person"),
        ]

        let tabBarControllers = configs.enumerated().map { tag, config -> UINavigationController in
            let (coordinator, tabTitle, imageName) = config
            let navigationController = createNavigationController(tabTitle: tabTitle, imageName: imageName, tag: tag)
            configCoordinator(coordinator, navigationController: navigationController)
            return navigationController
        }

        let tabBarController = TabBarController(with: tabBarControllers)
        navigationController.pushViewController(tabBarController, animated: true)
    }
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
