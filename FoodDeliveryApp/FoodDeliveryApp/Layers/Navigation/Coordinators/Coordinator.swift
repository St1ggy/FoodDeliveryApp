//
//  Coordinator.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 09.03.2024.
//

import UIKit

// MARK: - Coordinator Type

enum CoordinatorType {
    case app
    case onboarding
    case home
    case order
    case list
    case profile
}

// MARK: - Coordinator Finish Delegate

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol)
}

// MARK: - Coordinator Protocol

protocol CoordinatorProtocol: AnyObject {
    var type: CoordinatorType { get }
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController? { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set }

    func start()
    func finish()
}

// MARK: - Coordinator Protocol Extension

extension CoordinatorProtocol {
    func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }

    func addChildCoordinators(_ coordinators: CoordinatorProtocol...) {
        childCoordinators.append(contentsOf: coordinators)
    }

    func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    func removeChildCoordinators(_ coordinators: CoordinatorProtocol...) {
        childCoordinators.removeAll { childCoordinator in
            coordinators.contains { $0 === childCoordinator }
        }
    }
}
