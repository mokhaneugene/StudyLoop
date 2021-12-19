//
//  ClockView.swift
//  StudyLoop
//
//  Created by Eugene Mokhan on 07/11/2021.
//

import UIKit

final class ClockView: UIControl {
    // MARK: - Constants
    private struct Constants {
        static let dayAngle: CGFloat = 2 * .pi / CGFloat(Constants.numbers) * 8 // 8 hr
        static let nightAngle: CGFloat = 2 * .pi / CGFloat(Constants.numbers) * 20 // 20 hr
        static let numbers: Int = 24
        static let lineWidth: CGFloat = 30.0
        static let circleSpacing: CGFloat = 0.0
        static let outsideCircleBorder: CGFloat = 39.0
        static let thumbRadius: CGFloat = 15.0
        static let imageIconRadius: CGFloat = 11.0
        static let clockRadiusSpacing: CGFloat = 10.0
        static let clockNumberSpacing: CGFloat = 22.5
        static let divisionWidth: CGFloat = 1.0
        static let divisionHeight: CGFloat = 5.0
        static let divisionNumberOffset: CGFloat = .pi/50
        static let timeStackSpacing: CGFloat = 5
        static let secondsInDay: Int = 86400
    }

    // MARK: - Private properties
    private let outsideCircleLayer = CAShapeLayer()
    private let insideCircleLayer = CAShapeLayer()
    private let dayThumbLayer = ThumbLayer()
    private let nightThumbLayer = ThumbLayer()
    private let lineLayer = CAShapeLayer()
    private let insideCircleGradientLayer = CAGradientLayer()
    private let dayImageView = UIImageView()
    private let nightImageView = UIImageView()
    private let timeStackView = UIStackView()
    private let dayLabel = UILabel()
    private let nightLabel = UILabel()

    private var radius: CGFloat { bounds.width / 2 }
    private var insideCircleRadius: CGFloat = 0 {
        didSet {
            guard oldValue != insideCircleRadius else { return }
            setupClockNumbers()
            setupClockDivision()
        }
    }
    private var dayAngle: CGFloat = Constants.dayAngle {
        didSet {
            updateNightAngle(with: oldValue)
        }
    }
    private var nightAngle: CGFloat =  Constants.nightAngle {
        didSet {
            updateDayAngle(with: oldValue)
        }
    }

    // MARK: - Public properties
    var daySeconds: Int = 0 {
        didSet {
            updateDayLabel()
            if oldValue/3600 != daySeconds/3600 {
                sendActions(for: .valueChanged)
            }
        }
    }
    var nightSeconds: Int = 0 {
        didSet {
            updateNightLabel()
            if oldValue/3600 != nightSeconds/3600 {
                sendActions(for: .valueChanged)
            }
        }
    }

    // MARK: - Initializator
    init() {
        super.init(frame: .zero)
        setupItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        updateItems()
    }
}

extension ClockView {
    // MARK: - Tracking
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)

        let inset: CGFloat = 4
        if dayThumbLayer.frame.insetBy(dx: inset, dy: inset).contains(location) {
            dayThumbLayer.highlighted = true
        }
        if nightThumbLayer.frame.insetBy(dx: inset, dy: inset).contains(location) {
            nightThumbLayer.highlighted = true
        }

        return dayThumbLayer.highlighted || nightThumbLayer.highlighted
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        let x = location.x - radius
        let y = location.y - radius
        let divisor = radius*radius + x*x + y*y - (bounds.midX-location.x)*(bounds.midX-location.x) - (bounds.minY-location.y)*(bounds.minY-location.y)
        let denominator = 2 * radius * sqrt(x*x + y*y)
        let cosAngle = max(min(divisor/denominator, 1), -1)
        var angle = (location.x <= bounds.midX ? 2 * .pi : 0) + acos(cosAngle) * (location.x <= bounds.midX ? -1 : 1)
        if angle < 0 {
            let factor = -1 * angle / 2 / .pi + 1
            angle = angle + factor * 2 * .pi
        }
        if angle > 2 * .pi {
            let factor = angle / 2 / .pi
            angle = angle - factor * 2 * .pi
        }

        if dayThumbLayer.highlighted {
            dayAngle = angle
        }
        if nightThumbLayer.highlighted {
            nightAngle = angle
        }

        updateTime()

        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        dayThumbLayer.highlighted = false
        nightThumbLayer.highlighted = false
    }
}

private extension ClockView {
    // MARK: - Private methods
    func updateItems() {
        insideCircleRadius = bounds.width / 2  - Constants.outsideCircleBorder - Constants.circleSpacing
        updateOutsideCircleLayer()
        updateInsideCircleLayer()
        updateThumbs()
    }

    func updateThumbs() {
        CATransaction.setDisableActions(true)
        updateDayThumbLayer()
        updateNightThumbLayer()
        updateLineLayer()
        CATransaction.setDisableActions(false)
    }

    func setupItems() {
        setupOutsideCircleLayer()
        setupInsideCircleLayer()
        setupInsideCircleGradientLayer()
        setupLineLayer()
        setupDayThumbLayer()
        setupDayImageView()
        setupNightThumbLayer()
        setupNightImageView()
        setupTimeStackView()
        setupDayLabel()
        setupNightLabel()

        updateTime()
    }

    // MARK: - OutsideCircleLayer
    func updateOutsideCircleLayer() {
        let outsideCirclePath = UIBezierPath(arcCenter: .init(x: bounds.midX, y: bounds.midY),
                                             radius: bounds.width / 2  - Constants.outsideCircleBorder / 2,
                                             startAngle: 0,
                                             endAngle: 2 * .pi,
                                             clockwise: true)

        outsideCircleLayer.path = outsideCirclePath.cgPath
    }

    func setupOutsideCircleLayer() {
        layer.addSublayer(outsideCircleLayer)
        outsideCircleLayer.fillColor = UIColor.clear.cgColor
        outsideCircleLayer.strokeColor = R.color.outsideGrayColor()?.cgColor
        outsideCircleLayer.borderColor = R.color.outsideGrayColor()?.cgColor
        outsideCircleLayer.lineWidth = Constants.outsideCircleBorder
    }

    // MARK: - InsideCircleLayer
    func updateInsideCircleLayer() {
        let insideCirclePath = UIBezierPath(arcCenter: .init(x: bounds.midX, y: bounds.midY),
                                            radius: insideCircleRadius,
                                            startAngle: 0,
                                            endAngle: 2 * .pi,
                                            clockwise: true)

        insideCircleGradientLayer.frame = insideCirclePath.bounds
        insideCircleGradientLayer.cornerRadius = insideCirclePath.bounds.width / 2
        insideCircleLayer.path = insideCirclePath.cgPath
    }

    func setupInsideCircleLayer() {
        layer.addSublayer(insideCircleLayer)
        insideCircleLayer.fillColor = UIColor.clear.cgColor
        insideCircleLayer.strokeColor = UIColor.clear.cgColor
        insideCircleLayer.contents = R.image.sunnyIcon()?.cgImage
    }

    // MARK: - InsideCricleGradientLayer
    func setupInsideCircleGradientLayer() {
        layer.addSublayer(insideCircleGradientLayer)
        insideCircleGradientLayer.type = .radial
        insideCircleGradientLayer.colors = [R.color.radialGradientInside()!.cgColor,
                                            R.color.radialGradientOutside()!.cgColor]
        insideCircleGradientLayer.locations = [0.0, 1.0]
        insideCircleGradientLayer.startPoint = .init(x: 0.5, y: 0.5)
        insideCircleGradientLayer.endPoint = .init(x: 1, y: 1)
    }

    // MARK: - DayAngle
    func updateDayAngle(with oldValue: CGFloat) {
        if acos(cos(nightAngle - dayAngle)) <= .pi/12 {
            dayAngle += nightAngle - oldValue
        }
        updateThumbs()
    }

    // MARK: - DayThumbLayer
    func updateDayThumbLayer() {
        let radius = radius - Constants.outsideCircleBorder / 2
        let x = self.radius + radius * cos(dayAngle - .pi / 2)
        let y = self.radius + radius * cos(dayAngle + .pi)
        dayThumbLayer.frame = CGRect(x: x - Constants.thumbRadius,
                                     y: y - Constants.thumbRadius,
                                     width: 2 * Constants.thumbRadius,
                                     height: 2 * Constants.thumbRadius)
        dayImageView.frame = CGRect(x: x - Constants.imageIconRadius,
                                    y: y - Constants.imageIconRadius,
                                    width: 2 * Constants.imageIconRadius,
                                    height: 2 * Constants.imageIconRadius)
        dayThumbLayer.setNeedsDisplay()
    }

    func setupDayThumbLayer() {
        layer.addSublayer(dayThumbLayer)
        dayThumbLayer.fillColor = R.color.purple()?.cgColor
    }

    func setupDayImageView() {
        addSubview(dayImageView)
        dayImageView.image = R.image.sunnyIcon()
    }

    // MARK: - NightAngle
    func updateNightAngle(with oldValue: CGFloat) {
        if acos(cos(dayAngle - nightAngle)) <= .pi/12 {
            nightAngle += dayAngle - oldValue
        }
        updateThumbs()
    }

    // MARK: - NightThumbLayer
    func updateNightThumbLayer() {
        let radius = radius - Constants.outsideCircleBorder / 2
        let x = self.radius + radius * cos(nightAngle - .pi / 2)
        let y = self.radius + radius * cos(nightAngle + .pi)
        nightThumbLayer.frame = CGRect(x: x - Constants.thumbRadius,
                                       y: y - Constants.thumbRadius,
                                       width: 2 * Constants.thumbRadius,
                                       height: 2 * Constants.thumbRadius)
        nightImageView.frame = CGRect(x: x - Constants.imageIconRadius,
                                      y: y - Constants.imageIconRadius,
                                      width: 2 * Constants.imageIconRadius,
                                      height: 2 * Constants.imageIconRadius)
        nightThumbLayer.setNeedsDisplay()
    }

    func setupNightThumbLayer() {
        layer.addSublayer(nightThumbLayer)
        nightThumbLayer.fillColor = R.color.purple()?.cgColor
    }

    func setupNightImageView() {
        addSubview(nightImageView)
        nightImageView.image = R.image.moonIcon()
    }

    // MARK: - LineLayer
    func updateLineLayer() {
        let linePath = UIBezierPath(arcCenter: .init(x: bounds.midX, y: bounds.midY),
                                    radius: radius - Constants.outsideCircleBorder / 2,
                                    startAngle: dayAngle - .pi/2,
                                    endAngle: nightAngle - .pi/2,
                                    clockwise: true)
        lineLayer.path = linePath.cgPath
    }

    func setupLineLayer() {
        layer.addSublayer(lineLayer)
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = R.color.purple()?.cgColor
        lineLayer.lineWidth = Constants.lineWidth
    }

    // MARK: - UpateTime
    func updateTime() {
        let daySeconds = Int((dayAngle) / 2 / .pi * CGFloat(Constants.secondsInDay))
        let nightSeconds = Int((nightAngle) / 2 / .pi * CGFloat(Constants.secondsInDay))
        switch daySeconds {
        case ..<0:
            let factor = -1 * daySeconds / Constants.secondsInDay + 1
            self.daySeconds = daySeconds + factor * Constants.secondsInDay
        case (Constants.secondsInDay+1)...:
            let factor = daySeconds / Constants.secondsInDay
            self.daySeconds = daySeconds - factor * Constants.secondsInDay
        default:
            self.daySeconds = daySeconds
        }
        switch nightSeconds {
        case ..<0:
            let factor = -1 * nightSeconds / Constants.secondsInDay + 1
            self.nightSeconds = nightSeconds + factor * Constants.secondsInDay
        case (Constants.secondsInDay+1)...:
            let factor = nightSeconds / Constants.secondsInDay
            self.nightSeconds = nightSeconds - factor * Constants.secondsInDay
        default:
            self.nightSeconds = nightSeconds
        }
    }

    // MARK: - TimeStackView
    func setupTimeStackView() {
        addSubview(timeStackView)
        timeStackView.addArrangedSubview(dayLabel)
        timeStackView.addArrangedSubview(nightLabel)
        timeStackView.axis = .vertical
        timeStackView.spacing = Constants.timeStackSpacing
        timeStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // MARK: - DayLabel
    func updateDayLabel() {
        dayLabel.text = daySeconds.formatHoureMinute()
    }

    func setupDayLabel() {
        dayLabel.font = UIFont.systemFont(ofSize: 18)
        dayLabel.textColor = .white
    }

    // MARK: - NightLabel
    func updateNightLabel() {
        nightLabel.text = nightSeconds.formatHoureMinute()
    }

    func setupNightLabel() {
        nightLabel.font = UIFont.systemFont(ofSize: 18)
        nightLabel.textColor = .white
    }

    // MARK: - ClockNUmbers
    func setupClockNumbers() {
        let radius = insideCircleRadius - Constants.clockRadiusSpacing - Constants.clockNumberSpacing
        for i in 0...Constants.numbers - 1 {
            let number = UILabel()
            addSubview(number)
            number.setClockNumberStyle(with: i)
            let angle = 2 * CGFloat(i) * .pi / CGFloat(Constants.numbers) - .pi / 2
            number.snp.makeConstraints { make in
                make.centerX.equalTo(bounds.width / 2 + cos(angle) * radius)
                make.centerY.equalTo(bounds.width / 2 + sin(angle) * radius)
            }
        }
    }

    // MARK: - ClockDivision
    func setupClockDivision() {
        let radius = insideCircleRadius - Constants.clockRadiusSpacing
        for i in 0...Constants.numbers - 1 {
            let angle = 2 * CGFloat(i) * .pi / CGFloat(Constants.numbers) - .pi / 2
            let startPoint = CGPoint(x: bounds.width / 2 + cos(angle) * radius,
                                     y: bounds.width / 2 + sin(angle) * radius)
            let divisionLayer = CAShapeLayer()
            layer.addSublayer(divisionLayer)
            divisionLayer.fillColor = R.color.purple()?.cgColor
            divisionLayer.strokeColor = R.color.purple()?.cgColor
            divisionLayer.lineWidth = Constants.divisionWidth

            let divisionPath = i % 6 != 0
            ? lineDivision(with: startPoint, and: angle, radius: radius) : circleDivision(for: i, with: startPoint)

            divisionLayer.path = divisionPath.cgPath
        }
    }

    func circleDivision(for i: Int, with startPoint: CGPoint) -> UIBezierPath {
        let circleDivisionPath = UIBezierPath()

        let startAngle: CGFloat = i == 0
        ? 0 + Constants.divisionNumberOffset : i == 6
        ? .pi/2 + Constants.divisionNumberOffset : i == 12
        ? .pi + Constants.divisionNumberOffset : -.pi/2 + Constants.divisionNumberOffset

        let endAngle: CGFloat = i == 0
        ? .pi - Constants.divisionNumberOffset : i == 6
        ? -.pi/2 - Constants.divisionNumberOffset : i == 12
        ? 0 - Constants.divisionNumberOffset : .pi/2 - Constants.divisionNumberOffset

        let radius = Constants.divisionHeight
        circleDivisionPath.move(to: startPoint)
        circleDivisionPath.addLine(to: .init(x: startPoint.x + radius * cos(startAngle),
                                             y: startPoint.y + radius * sin(startAngle)))
        circleDivisionPath.addArc(withCenter: startPoint,
                                  radius: radius,
                                  startAngle: startAngle,
                                  endAngle: endAngle,
                                  clockwise: true)
        circleDivisionPath.close()

        return circleDivisionPath
    }

    func lineDivision(with startPoint: CGPoint, and angle: CGFloat, radius: CGFloat) -> UIBezierPath {
        let lineDivisionPath = UIBezierPath()
        lineDivisionPath.move(to: startPoint)
        lineDivisionPath.addLine(to: .init(x: bounds.width / 2 + cos(angle) * (radius - Constants.divisionHeight),
                                           y: bounds.width / 2 + sin(angle) * (radius - Constants.divisionHeight)))
        return lineDivisionPath
    }
}
