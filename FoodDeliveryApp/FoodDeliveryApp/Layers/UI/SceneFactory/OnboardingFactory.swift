//
//  OnboardingFactory.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 11.03.2024.
//

import UIKit

enum OnboardingFactory {
    static func createOnboardingFlow(
        coordinator: AppCoordinator,
        navigationController: UINavigationController,
        finishDelegate: CoordinatorFinishDelegate
    ) {
        let onboardingCoordinator = OnboardingCoordinator(
            navigationController: navigationController,
            finishDelegate: finishDelegate
        )

        coordinator.addChildCoordinator(onboardingCoordinator)

        onboardingCoordinator.start()
    }

    static func createOnboardingScene(
        coordinator: OnboardingCoordinator
    ) -> OnboardingViewController {
        var pages = [UIViewController]()

        pages.append(contentsOf: [
            OnboardingPageViewController(
                image: .onboardingPage1,
                titleText: "Delicious Food",
                descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ),
            OnboardingPageViewController(
                image: .onboardingPage2,
                titleText: "Fast Shipping",
                descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Interdum rhoncus nulla."
            ),
            OnboardingPageViewController(
                image: .onboardingPage3,
                titleText: "Certificate Food",
                descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ultricies mauris a id."
            ),
            OnboardingPageViewController(
                image: .onboardingPage4,
                titleText: "Payment Online",
                descriptionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dui ultricies sit massa."
            ),
        ])

        let presenter = OnboardingViewPresenter(coordinator: coordinator)
        let viewController = OnboardingViewController(pages: pages, viewOutput: presenter)

        return viewController
    }
}
