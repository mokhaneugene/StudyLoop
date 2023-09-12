//
//  SettingsCell.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 20/12/2021.
//

import UIKit

final class SettingsCell: UITableViewCell {
    // MARK: - Private properties
    private let bgView = UIView()
    private let horizontalStackView = UIStackView()
    private let bgIconImageView = UIView()
    private let iconImageView = UIImageView()
    private let verticalStackView = UIStackView()
    private let titleLabel = UILabel()
    private let summaryLabel = UILabel()

    // MARK: - Public properties
    static let reuseId = "SettingsCell"

    // MARK: - Initializator
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func configure(with model: Model) {
        titleLabel.text = model.title
        summaryLabel.text = model.summary
    }
}

private extension SettingsCell {
    // MARK: - Private methods
    func setupItems() {
        backgroundColor = .clear
        setupBGView()
        setupHorizontalStackView()
        setupIconImageView()
        setupVerticalStackView()
        setupTitleLabel()
        setupSummaryLabel()
    }

    func setupBGView() {
        addSubview(bgView)
        bgView.backgroundColor = R.color.gray()
        bgView.layer.cornerRadius = 15
        bgView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.center.equalToSuperview()
        }
    }

    func setupHorizontalStackView() {
        bgView.addSubview(horizontalStackView)
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 0
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(bgIconImageView)
        horizontalStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(20)
            make.center.equalToSuperview()
        }
    }

    func setupIconImageView() {
        bgIconImageView.snp.makeConstraints { make in
            make.width.equalTo(11)
        }
        bgIconImageView.addSubview(iconImageView)
        iconImageView.image = R.image.arrowIcon()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(11)
            make.height.equalTo(18)
            make.center.equalTo(bgIconImageView)
        }
    }

    func setupVerticalStackView() {
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 5
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(summaryLabel)
    }

    func setupTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 20)
    }

    func setupSummaryLabel() {
        summaryLabel.textColor = .white
        summaryLabel.numberOfLines = 0
        summaryLabel.textAlignment = .left
        summaryLabel.font = .systemFont(ofSize: 17)
    }
}
