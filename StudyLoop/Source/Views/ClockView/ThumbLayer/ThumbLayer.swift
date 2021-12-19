//
//  ThumbLayer.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 17/11/2021.
//

import UIKit

final class ThumbLayer: CAShapeLayer {
    // MARK: -  Public properties
    var highlighted: Bool = false

    // MARK: - LifeCycle
    override func layoutSublayers() {
        super.layoutSublayers()
        let nightThumbPath = UIBezierPath(arcCenter: .init(x: bounds.midX, y: bounds.midY),
                                          radius: 15,
                                          startAngle: 0,
                                          endAngle: 2 * .pi,
                                          clockwise: true)
        path = nightThumbPath.cgPath
    }
}
