//
//  AuthorizationViewController.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 11.03.2024.
//

import SnapKit
import UIKit

class AuthorizationViewController: UIViewController {
    private lazy var footer = AuthorizationFooterView(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
}

private extension AuthorizationViewController {
    func layoutUI() {
        addSubviews(footer)

        view.backgroundColor = .appWhite

        configFooter()
    }

    func configFooter() {
        footer.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension AuthorizationViewController: AuthorizationFooterDelegate {
    func didTapFacebookButton() {
        print("didTapFacebookButton")
    }
    
    func didTapGoogleButton() {
        print("didTapGoogleButton")
    }
    

}
