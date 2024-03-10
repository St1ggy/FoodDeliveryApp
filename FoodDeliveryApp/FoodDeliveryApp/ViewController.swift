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

        view.backgroundColor = .appBackground

        let label = UILabel()
        label.text = "Hello World!"
        label.font = .roboto.italic.size(of: 20)
        label.textAlignment = .center
        label.textColor = .appAccent

        addSubviews(label)

        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
