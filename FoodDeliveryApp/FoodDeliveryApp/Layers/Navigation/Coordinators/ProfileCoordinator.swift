//
//  ProfileCoordinator.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 10.03.2024.
//

import UIKit

class ProfileCoordinator: Coordinator {
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .systemRed
        navigationController?.pushViewController(vc, animated: true)
    }

    override func finish() {
        print("ProfileCoordinator Finish")
    }
}

extension ProfileCoordinator {
    convenience init(
        childCoordinators: [CoordinatorProtocol] = [CoordinatorProtocol](),
        navigationController: UINavigationController? = nil,
        finishDelegate: (any CoordinatorFinishDelegate)? = nil
    ) {
        self.init(
            type: .profile,
            childCoordinators: childCoordinators,
            navigationController: navigationController,
            finishDelegate: finishDelegate
        )
    }
}
