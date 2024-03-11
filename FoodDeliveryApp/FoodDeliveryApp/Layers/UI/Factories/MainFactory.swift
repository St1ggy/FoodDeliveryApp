//
//  SceneFactory.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 11.03.2024.
//

import UIKit

enum MainFactory {
    private static func createNavigationController(
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

    private static func configCoordinator(
        _ coordinator: Coordinator,
        navigationController: UINavigationController,
        finishDelegate: CoordinatorFinishDelegate
    ) {
        coordinator.navigationController = navigationController
        coordinator.finishDelegate = finishDelegate
        coordinator.start()
    }

    static func createMainFlow(
        coordinator: AppCoordinator,
        navigationController _: UINavigationController,
        finishDelegate: CoordinatorFinishDelegate
    ) -> TabBarController {
        let configs: [(Coordinator, String, String)] = [
            (HomeCoordinator(), "Home", "house"),
            (OrderCoordinator(), "Order", "cart"),
            (ListCoordinator(), "List", "list.dash"),
            (ProfileCoordinator(), "Profile", "person"),
        ]

        let tabBarControllers = configs.enumerated().map { tag, config -> UINavigationController in
            let (childCoordinator, tabTitle, imageName) = config
            let navigationController = createNavigationController(
                tabTitle: tabTitle,
                imageName: imageName,
                tag: tag
            )

            configCoordinator(
                childCoordinator,
                navigationController: navigationController,
                finishDelegate: finishDelegate
            )

            coordinator.addChildCoordinator(childCoordinator)

            return navigationController
        }

        let tabBarController = TabBarController(with: tabBarControllers)

        return tabBarController
    }
}
