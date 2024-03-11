//
//  OnboardingPageViewController.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 10.03.2024.
//

import SnapKit
import UIKit

class OnboardingPageViewController: UIViewController {
    // MARK: - Properties

    var image: UIImage?
    var titleText: String?
    var descriptionText: String?

    // MARK: - Views

    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var descriptionLabel = UILabel()

    // MARK: - Init

    init(image: ImageResource, titleText: String, descriptionText: String) {
        super.init(nibName: nil, bundle: nil)

        self.image = UIImage(resource: image)
        self.titleText = titleText
        self.descriptionText = descriptionText
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutUI()
    }
}

// MARK: - Layout

private extension OnboardingPageViewController {
    func layoutUI() {
        configView()
        configImageView()
        configTitleLabel()
        configDescriptionLabel()
    }

    func configView() {
        view.backgroundColor = .appAccent
    }

    func configImageView() {
        addSubview(imageView)

        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
            $0.size.equalTo(200)
        }

        imageView.image = image
    }

    func configTitleLabel() {
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(70)
        }

        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = titleText
        titleLabel.textColor = .appWhite
        titleLabel.font = .roboto.bold.size(of: 24)
    }

    func configDescriptionLabel() {
        addSubview(descriptionLabel)

        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(70)
        }

        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = descriptionText
        descriptionLabel.textColor = .appWhite
        descriptionLabel.font = .roboto.regular.size(of: 14)
    }
}
