//
//  UIViewController+Ext.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 09.03.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
}
