//
//  UserStorageService.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 11.03.2024.
//

import Foundation

enum UserStorageService {
//    static let shared = UserStorageService()

    static var onboardingShown: Bool {
        get { UserDefaults.standard.bool(forKey: "onboardingShown") }
        set { UserDefaults.standard.set(newValue, forKey: "onboardingShown") }
    }
}
