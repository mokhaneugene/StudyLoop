//
//  TabBarViewController.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit
import SnapKit

final class TabBarViewContorller: UITabBarController {
    // MARK: - Private methods
    private var viewModel: TabBarViewModel?
    private var button = UIButton()

    // MARK: - Configure
    func configure(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
    }

    @objc func didTapButton() {
        self.viewModel?.didTapButton()
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(150)
        }
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
    }
}
