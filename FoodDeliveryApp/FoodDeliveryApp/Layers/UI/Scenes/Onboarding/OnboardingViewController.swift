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

    private var pages = [OnboardingPageViewController]()

    // MARK: - Views

    private lazy var pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                               navigationOrientation: .horizontal)
    private lazy var pageControl = UIPageControl()
    private lazy var button = FDButton(buttonType: .secondary)
    var viewOutput: OnboardingViewOutput!

    init(pages: [OnboardingPageViewController] = [OnboardingPageViewController](), viewOutput: OnboardingViewOutput? = nil) {
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
        if pageControl.currentPage == pages.count - 1 {
            viewOutput?.finishOnboarding()
        } else {
            let nextPageIndex = pageControl.currentPage + 1
            let nextPage = pages[nextPageIndex]
            pageViewController.setViewControllers([nextPage], direction: .forward, animated: true)
            pageControl.currentPage = nextPageIndex
            updateButton(index: nextPageIndex)
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
            $0.bottom.equalTo(pageControl.snp.top).offset(-36)
            $0.leading.trailing.equalToSuperview().inset(30)
        }

        updateButton()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    func updateButton(index: Int = 0) {
        let page = pages[index]
        button.setTitle(page.buttonText)
        button.setColorStyle(page.buttonType)
    }
}

// MARK: - UIPageViewControllerDataSource Delegate

extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController as! OnboardingPageViewController), currentIndex > 0 else { return nil }

        return pages[currentIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController as! OnboardingPageViewController), currentIndex < pages.count - 1 else { return nil }

        return pages[currentIndex + 1]
    }
}

// MARK: - UIPageViewControllerDelegate Delegate

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first, let index = pages.firstIndex(of: currentViewController as! OnboardingPageViewController) {
                pageControl.currentPage = index
                updateButton(index: index)
            }
        }
    }
}
