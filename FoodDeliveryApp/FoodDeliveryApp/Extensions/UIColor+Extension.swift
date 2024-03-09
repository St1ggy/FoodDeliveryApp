//
//  UIColor+Extension.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 09.03.2024.
//

import UIKit

extension UIColor {
    static func hex(_ rgb: UInt32) -> UIColor {
        UIColor(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
