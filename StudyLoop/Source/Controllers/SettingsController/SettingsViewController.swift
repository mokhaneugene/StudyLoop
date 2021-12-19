//
//  SettingsViewController.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - Private properties
    private var viewModel: SettingsViewModel?

    // MARK: - Configure
    func configure(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        view.backgroundColor = R.color.bg()
    }
}
