//
//  OnboardingCoordinator.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 10.03.2024.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    override func start() {
        showOnboarding()
    }

    override func finish() {
        print("OnboardingCoordinator Finish")
    }
}

private extension OnboardingCoordinator {
    func showOnboarding() {
        var pages = [UIViewController]()

        pages.append(contentsOf: [
            OnboardingPageViewController(
                image: UIImage(resource: .onboardingPage1),
                titleText: "Delicious Food",
                descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ),
            OnboardingPageViewController(
                image: UIImage(resource: .onboardingPage2),
                titleText: "Fast Shipping",
                descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Interdum rhoncus nulla."
            ),
            OnboardingPageViewController(
                image: UIImage(resource: .onboardingPage3),
                titleText: "Certificate Food",
                descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ultricies mauris a id."
            ),
            OnboardingPageViewController(
                image: UIImage(resource: .onboardingPage4),
                titleText: "Payment Online",
                descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dui ultricies sit massa."
            )
        ])

        let presenter = OnboardingViewPresenter(coordinator: self)
        let viewController = OnboardingViewController(pages: pages, viewOutput: presenter)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension OnboardingCoordinator {
    convenience init(
        childCoordinators: [CoordinatorProtocol] = [CoordinatorProtocol](),
        navigationController: UINavigationController? = nil,
        finishDelegate: (any CoordinatorFinishDelegate)? = nil
    ) {
        self.init(
            type: .onboarding,
            childCoordinators: childCoordinators,
            navigationController: navigationController,
            finishDelegate: finishDelegate
        )
    }
}
