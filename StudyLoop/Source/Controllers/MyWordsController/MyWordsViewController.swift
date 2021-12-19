//
//  MyWordsViewController.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit

final class MyWordsViewController: UIViewController {
    // MARK: - Private properties
    private let clockView = ClockView()

    private var viewModel: MyWordsViewModel?

    // MARK: - Configure
    func configure(viewModel: MyWordsViewModel) {
        self.viewModel = viewModel
        view.backgroundColor = R.color.bg()
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
    }
}

private extension MyWordsViewController {
    // MARK: - Private methods
    func setupItems() {
        setupClockView()
    }

    func setupClockView() {
        view.addSubview(clockView)
        clockView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(50)
            make.width.equalTo(clockView.snp.height)
        }

        clockView.addTarget(self, action: #selector(didChangeClockValue), for: .valueChanged)
    }

    @objc func didChangeClockValue() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}
