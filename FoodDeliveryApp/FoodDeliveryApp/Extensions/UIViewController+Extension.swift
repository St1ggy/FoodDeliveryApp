//
//  UIViewController+Ext.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 09.03.2024.
//

import UIKit

extension UIViewController {
    func addSubview(_ view: UIView) {
        self.view.addSubview(view)
    }

    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
}
