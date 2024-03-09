//
//  TabBarController.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 10.03.2024.
//

import UIKit

class TabBarController: UITabBarController {
    init(with tabBarControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        tabBarControllers.forEach { self.addChild($0) }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = AppColors.background
        tabBar.tintColor = AppColors.accent
    }
}
