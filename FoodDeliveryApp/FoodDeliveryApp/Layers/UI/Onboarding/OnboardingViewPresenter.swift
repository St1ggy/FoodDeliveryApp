//
//  OnboardingViewPresenter.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 10.03.2024.
//

import UIKit

protocol OnboardingViewOutput: AnyObject {
    func finishOnboarding()
}

class OnboardingViewPresenter: OnboardingViewOutput {
    // MARK: - Properties

    weak var coordinator: OnboardingCoordinator!

    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
    }

    func finishOnboarding() {
        UserStorageService.onboardingShown = true
        coordinator.finish()
    }
}
