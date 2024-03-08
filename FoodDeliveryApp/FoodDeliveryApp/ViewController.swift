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

        view.backgroundColor = .systemRed

        let label = UILabel()
        label.text = "Hello World!"
        label.font = .Roboto.blackItalic.size(of: 40)
        label.textAlignment = .center

        addSubviews(label)

        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
