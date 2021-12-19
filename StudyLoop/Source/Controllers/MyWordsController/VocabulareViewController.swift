//
//  MyWordsViewController.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit

final class MyWordsViewController: UIViewController {
    // MARK: - Private properties
    private var viewModel: MyWordsViewModel?

    // MARK: - Configure
    func configure(viewModel: MyWordsViewModel) {
        self.viewModel = viewModel
        view.backgroundColor = R.color.bg()
    }
}
