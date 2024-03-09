//
//  ViewController.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 08.03.2024.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.background

        let label = UILabel()
        label.text = "Hello World!"
        label.font = .Roboto.italic.size(of: 20)
        label.textAlignment = .center
        label.textColor = AppColors.accent

        addSubviews(label)

        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
