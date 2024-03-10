//
//  OnboardingViewController.swift
//  FoodDeliveryApp
//
//  Created by Dmitrii Bragin on 10.03.2024.
//

import SnapKit
import UIKit

// MARK: - OnboardingViewController

class OnboardingViewController: UIViewController {
    // MARK: - Properties

    private var pages = [UIViewController]()

    // MARK: - Views

    private lazy var pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                               navigationOrientation: .horizontal)
    private lazy var pageControl = UIPageControl()
    private lazy var button = UIButton()
    weak var viewOutput: OnboardingViewOutput?

    init(pages: [UIViewController] = [UIViewController](), viewOutput: OnboardingViewOutput? = nil) {
        super.init(nibName: nil, bundle: nil)

        self.pages = pages
        self.viewOutput = viewOutput
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .appAccent

        layoutUI()
    }
}

// MARK: - Actions

private extension OnboardingViewController {
    @objc func didTapButton() {
        if pageControl.currentPage == pages.count - 1 {}
        else {
            let nextPageIndex = pageControl.currentPage + 1
            let nextPage = pages[nextPageIndex]
            pageViewController.setViewControllers([nextPage], direction: .forward, animated: true)
            pageControl.currentPage = nextPageIndex
            updateButtonText(index: nextPageIndex)
        }
    }
}

// MARK: - Layout

private extension OnboardingViewController {
    func layoutUI() {
        configPageViewController()
        configPageControl()
        configButton()
    }

    func configPageViewController() {
        pageViewController.delegate = self
        pageViewController.dataSource = self

        pageViewController.setViewControllers([pages.first!],
                                              direction: .forward,
                                              animated: true)

        addChild(pageViewController)
        addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }

    func configPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false

        addSubview(pageControl)

        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func configButton() {
        addSubview(button)

        button.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(pageControl.snp.top).offset(-36)
            $0.height.equalTo(50)
        }

        button.backgroundColor = .appGrey
        updateButtonText()
        button.setTitleColor(.appAccent, for: .normal)
        button.titleLabel?.font = .roboto.bold.size(of: 18)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    func updateButtonText(index: Int = 0) {
        button.setTitle(index == pages.count - 1 ? "Get Started" : "Next", for: .normal)
    }
}

// MARK: - UIPageViewControllerDataSource Delegate

extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else { return nil }

        return pages[currentIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else { return nil }

        return pages[currentIndex + 1]
    }
}

// MARK: - UIPageViewControllerDelegate Delegate

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first, let index = pages.firstIndex(of: currentViewController) {
                pageControl.currentPage = index
                updateButtonText(index: index)
            }
        }
    }
}
