//
//  MainFlow+Appearance.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 06/11/2021.
//

import UIKit

extension MainFlow {
    func configureTabBarAppearance(appearance: UITabBarAppearance) {
        let normalTitleTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white.withAlphaComponent(0.6),
                                                                        .font: UIFont.systemFont(ofSize: 14)]
        let selectedTitleTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white,
                                                                          .font: UIFont.systemFont(ofSize: 14)]

        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = R.color.bg()
        appearance.shadowColor = UIColor.clear

        let stackedLayoutAppearance = UITabBarItemAppearance(style: .stacked)
        stackedLayoutAppearance.normal.titleTextAttributes = normalTitleTextAttributes
        stackedLayoutAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.6)
        stackedLayoutAppearance.selected.titleTextAttributes = selectedTitleTextAttributes
        stackedLayoutAppearance.selected.iconColor = UIColor.white

        appearance.stackedLayoutAppearance = stackedLayoutAppearance
        UITabBar.appearance().standardAppearance = appearance

        // Be sure to add these lines in order to fix problems with Labels on iOS 13
        UITabBarItem.appearance().setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes(normalTitleTextAttributes, for: .normal)

        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
