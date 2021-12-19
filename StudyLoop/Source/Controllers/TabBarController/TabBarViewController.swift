//
//  TabBarViewController.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit
import SnapKit

final class TabBarViewContorller: UITabBarController {
    // MARK: - Private properties
    private var viewModel: TabBarViewModel?

    // MARK: - Configure
    func configure(viewModel: TabBarViewModel) {
        self.viewModel = viewModel

        let controllers = viewModel.controllers()
        self.setViewControllers(controllers, animated: false)
    }
}
