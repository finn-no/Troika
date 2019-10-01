//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public final class SplashView: UIView {
    private lazy var leftLogoView: UIImageView = {
        let imageView = UIImageView(withAutoLayout: true)
        imageView.image = UIImage(named: .splashLogo)
        return imageView
    }()

    private lazy var rightLogoView: UIView = {
        let view = UIView(withAutoLayout: true)
        view.clipsToBounds = true
        view.backgroundColor = .secondaryBlue
        view.layer.borderColor = .milk
        view.layer.borderWidth = 3
        view.layer.cornerRadius = 4
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return view
    }()

    private lazy var letterViews: [UIView] = {
        let assets: [FinniversImageAsset] = [.splashLetters1, .splashLetters2, .splashLetters3, .splashLetters4]
        return assets.map {
            let imageView = UIImageView(withAutoLayout: true)
            imageView.image = UIImage(named: $0)
            imageView.alpha = 0
            return imageView
        }
    }()

    private lazy var rightLogoViewWidthConstraint = rightLogoView.widthAnchor.constraint(equalToConstant: 50)

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = .secondaryBlue

        addSubview(leftLogoView)
        addSubview(rightLogoView)

        letterViews.forEach({ addSubview($0) })

        NSLayoutConstraint.activate([
            leftLogoView.trailingAnchor.constraint(equalTo: rightLogoView.leadingAnchor, constant: 1),
            leftLogoView.centerYAnchor.constraint(equalTo: centerYAnchor),

            rightLogoView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 23),
            rightLogoView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightLogoView.heightAnchor.constraint(equalToConstant: 50),
            rightLogoViewWidthConstraint,

            letterViews[0].leadingAnchor.constraint(equalTo: centerXAnchor, constant: -8),
            letterViews[0].bottomAnchor.constraint(equalTo: rightLogoView.bottomAnchor),

            letterViews[1].leadingAnchor.constraint(equalTo: letterViews[0].trailingAnchor, constant: 4),
            letterViews[1].bottomAnchor.constraint(equalTo: letterViews[0].bottomAnchor),

            letterViews[2].leadingAnchor.constraint(equalTo: letterViews[1].trailingAnchor, constant: 4),
            letterViews[2].bottomAnchor.constraint(equalTo: letterViews[0].bottomAnchor),

            letterViews[3].leadingAnchor.constraint(equalTo: letterViews[2].trailingAnchor, constant: 4),
            letterViews[3].bottomAnchor.constraint(equalTo: letterViews[0].bottomAnchor)
        ])
    }

    public func animate() {
        rightLogoViewWidthConstraint.constant = 100

        animateConstraints(withDuration: 0.225, completion: {
            self.rightLogoViewWidthConstraint.constant = 95

            self.animateConstraints(withDuration: 0.05, completion: {
                self.rightLogoViewWidthConstraint.constant = 96
                self.animateConstraints(withDuration: 0.025)
            })
        })

        var delay: TimeInterval = 0.05

        for letterView in letterViews {
            letterView.layer.add(makeLetterAnimation(withDelay: delay), forKey: nil)
            delay += 0.05
        }
    }

    private func animateConstraints(withDuration duration: TimeInterval, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: {
            self.layoutIfNeeded()
        }, completion: { _ in
            completion?()
        })
    }

    private func makeLetterAnimation(withDelay delay: TimeInterval) -> CAAnimationGroup {
        let transform = CABasicAnimation(keyPath: "transform.translation.y")
        transform.toValue = -15
        transform.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 1.8, 1, 1)

        let alpha = CABasicAnimation(keyPath: "opacity")
        alpha.toValue = 1

        let group = CAAnimationGroup()
        group.animations = [alpha, transform]
        group.beginTime = CACurrentMediaTime() + delay
        group.duration = 0.3
        group.fillMode = .forwards
        group.isRemovedOnCompletion = false

        return group
    }
}
