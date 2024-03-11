//
//  AuthorizationFooterView.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 11.03.2024.
//

import SnapKit
import UIKit

protocol AuthorizationFooterDelegate: AnyObject {
    func didTapFacebookButton()
    func didTapGoogleButton()
}

class AuthorizationFooterView: UIView {
    private lazy var label = UILabel()
    private lazy var lineView = UIView()
    private lazy var imageView = UIImageView()
    private lazy var buttonsContainerView = UIStackView()

    var delegate: AuthorizationFooterDelegate

    init(delegate: AuthorizationFooterDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)

        layoutUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutUI() {
        addSubviews(
            label,
            lineView,
            imageView,
            buttonsContainerView
        )

        configView()
        configLabel()
        configLineView()
        configImageView()
        configButtonsContainerView()
    }

    private func configView() {
        layoutMargins.right = 30
        snp.makeConstraints {
            $0.height.equalTo(150)
        }
    }

    private func configLabel() {
        label.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailingMargin.equalToSuperview()
        }

        label.font = .roboto.regular.size(of: 14)
        label.textColor = .appSecondary
        label.text = "Or connect with"
    }

    private func configLineView() {
        lineView.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.centerY.equalTo(label)
            $0.leading.equalToSuperview().inset(-1)
            $0.trailing.equalTo(label.snp.leading).inset(-12)
        }

        lineView.backgroundColor = .appSecondary.withAlphaComponent(0.3)
        lineView.layer.cornerRadius = 1
    }

    private func configImageView() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(-75)
            $0.bottom.equalToSuperview().inset(-30)
        }

        imageView.image = UIImage(resource: .authorizationFooter)
    }

    private func configButtonsContainerView() {
        buttonsContainerView.axis = .horizontal
        buttonsContainerView.spacing = 20

        buttonsContainerView.snp.makeConstraints {
            $0.trailingMargin.equalToSuperview()
            $0.top.equalTo(label.snp.bottom).offset(20)
        }

        let buttonsConfig: [(ImageResource, Selector)] = [
            (.facebookButton, #selector(didTapFacebookButton)),
            (.googleButton, #selector(didTapGoogleButton))
        ]

        for (buttonImage, selector) in buttonsConfig {
            let button = UIButton()

            buttonsContainerView.addArrangedSubview(button)

            button.snp.makeConstraints {
                $0.size.equalTo(40)
            }

            button.layer.cornerRadius = 20
            button.addTarget(self, action: selector, for: .touchUpInside)
            button.setImage(UIImage(resource: buttonImage), for: .normal)
        }
    }

    @objc private func didTapFacebookButton() {
        delegate.didTapFacebookButton()
    }

    @objc private func didTapGoogleButton() {
        delegate.didTapGoogleButton()
    }
}

#Preview("AuthorizationFooterView", traits: .fixedLayout(width: 393, height: 150)) {
    AuthorizationViewController()
}
