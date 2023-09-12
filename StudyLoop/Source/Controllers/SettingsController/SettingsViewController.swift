//
//  SettingsViewController.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - Private properties
    private let tableView = UITableView()

    private var viewModel: SettingsViewModel!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }

    // MARK: - Configure
    func configure(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        view.backgroundColor = R.color.bg()
    }
}

private extension SettingsViewController {
    // MARK: - Private methods
    func setupViewModel() {
        viewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .onDataReady:
                self.setupItems()
            }
        }

        viewModel.launch()
    }

    func setupItems() {
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
            make.height.equalTo(279)
        }
        tableView.backgroundColor = .clear
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseId)
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SettingsViewController: UITableViewDataSource {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellsModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseId, for: indexPath)
        viewModel.setModelForSettingCell(cell as? SettingsCell, indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
}

extension SettingsViewController: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
