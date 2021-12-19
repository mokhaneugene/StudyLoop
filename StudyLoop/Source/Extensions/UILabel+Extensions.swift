//
//  UILabel+Extensions.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 07/11/2021.
//

import UIKit

extension UILabel {
    func setClockNumberStyle(with number: Int) {
        text = number % 2 == 0 ? String(number) : nil
        textColor = UIColor.white
        font = UIFont.systemFont(ofSize: 14)
    }
}
