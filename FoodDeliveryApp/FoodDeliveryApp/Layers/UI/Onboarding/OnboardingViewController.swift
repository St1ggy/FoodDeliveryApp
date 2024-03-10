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

    private var pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                          navigationOrientation: .horizontal)
    private var pageControl = UIPageControl()
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

        configPageViewController()
        configPageControl()
    }
}

// MARK: - Layout

private extension OnboardingViewController {
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

        addSubview(pageControl)

        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
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
            }
        }
    }
}
