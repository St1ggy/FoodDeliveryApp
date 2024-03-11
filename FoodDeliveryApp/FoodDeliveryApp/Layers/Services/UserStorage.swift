//
//  UserStorage.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 11.03.2024.
//

import Foundation

enum UserStorage {
    private static let defaults = UserDefaults.standard

    private enum UserStorageKey: String {
        case onboardingShown
    }

    private static func set(_ value: Any, forKey key: UserStorageKey) {
        defaults.set(value, forKey: key.rawValue)
    }

    private static func get<T>(forKey key: UserStorageKey) -> T? {
        defaults.value(forKey: key.rawValue) as? T
    }

    static var onboardingShown: Bool {
        get { get(forKey: .onboardingShown)! }
        set { set(newValue, forKey: .onboardingShown) }
    }
}
