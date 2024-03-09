//
//  AppCoordinator.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 10.03.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    override func start() {
//        showOnboardingFlow()
        showMainFlow()
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

    func showMainFlow() {
        guard let navigationController = navigationController else { return }

        let homeNavigationController = UINavigationController()
        homeNavigationController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        homeCoordinator.finishDelegate = self
        homeCoordinator.start()

        let orderNavigationController = UINavigationController()
        orderNavigationController.tabBarItem = UITabBarItem(
            title: "Order",
            image: UIImage(systemName: "swirl.circle.righthalf.filled"),
            tag: 1
        )
        let orderCoordinator = OrderCoordinator(navigationController: orderNavigationController)
        orderCoordinator.finishDelegate = self
        orderCoordinator.start()

        let listNavigationController = UINavigationController()
        listNavigationController.tabBarItem = UITabBarItem(
            title: "List",
            image: UIImage(systemName: "swirl.circle.righthalf.filled"),
            tag: 2
        )
        let listCoordinator = ListCoordinator(navigationController: listNavigationController)
        listCoordinator.finishDelegate = self
        listCoordinator.start()

        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "swirl.circle.righthalf.filled"),
            tag: 3
        )
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        profileCoordinator.finishDelegate = self
        profileCoordinator.start()

        addChildCoordinators(homeCoordinator, orderCoordinator, listCoordinator, profileCoordinator)

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
