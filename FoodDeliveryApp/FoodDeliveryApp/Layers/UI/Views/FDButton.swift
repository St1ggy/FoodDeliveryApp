//
//  FDButton.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 11.03.2024.
//

import SnapKit
import UIKit

enum FDButtonType {
    case primary
    case secondary
    case accent

    var backgroundColor: UIColor {
        switch self {
            case .accent:
                .appAccent
            case .primary:
                .appWhite
            case .secondary:
                .appGrey
        }
    }

    var titleColor: UIColor {
        switch self {
            case .accent:
                .appWhite
            case .primary:
                .appAccent
            case .secondary:
                .appBlack
        }
    }
}

class FDButton: UIButton {
    init(buttonType: FDButtonType = .primary) {
        super.init(frame: .zero)

        setColorStyle(buttonType)
        configButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configButton() {
        let size = 50.0
        superview?.addSubview(self)
        snp.makeConstraints { $0.height.equalTo(size) }

        titleLabel?.font = .roboto.bold.size(of: 18)
        layer.cornerRadius = size / 2
    }

    func setTitle(_ title: String) {
        setTitle(title, for: .normal)
    }

    func setColorStyle(_ buttonType: FDButtonType) {
        backgroundColor = buttonType.backgroundColor
        setTitleColor(buttonType.titleColor, for: .normal)
    }
}
