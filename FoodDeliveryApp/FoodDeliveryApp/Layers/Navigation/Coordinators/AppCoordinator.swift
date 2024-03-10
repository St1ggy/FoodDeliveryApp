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

    func configCoordinator(
        coordinator: Coordinator,
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

        coordinator.navigationController = navigationController
        coordinator.finishDelegate = self
        coordinator.start()

        addChildCoordinator(coordinator)

        return navigationController
    }

    func showMainFlow() {
        guard let navigationController = navigationController else { return }

        let homeNavigationController = configCoordinator(
            coordinator: HomeCoordinator(),
            tabTitle: "Home",
            imageName: "house",
            tag: 0
        )

        let orderNavigationController = configCoordinator(
            coordinator: OrderCoordinator(),
            tabTitle: "Order",
            imageName: "cart",
            tag: 1
        )

        let listNavigationController = configCoordinator(
            coordinator: ListCoordinator(),
            tabTitle: "List",
            imageName: "list.dash",
            tag: 2
        )

        let profileNavigationController = configCoordinator(
            coordinator: ProfileCoordinator(),
            tabTitle: "Profile",
            imageName: "person",
            tag: 3
        )

        let tabBarControllers = [
            homeNavigationController,
            orderNavigationController,
            listNavigationController,
            profileNavigationController,
        ]

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
