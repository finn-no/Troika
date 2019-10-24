//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public class BottomShadowView: UIView {
    static let maxShadowRadius: CGFloat = 3

    // MARK: - Public properties

    public var isShadowHidden: Bool {
        get { layer.shadowRadius != 0 }
        set { layer.shadowRadius = newValue ? 0 : BottomShadowView.maxShadowRadius }
    }

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Overrides

    public override func layoutSubviews() {
        super.layoutSubviews()
        // Make shadow to be on bottom
        let radius = BottomShadowView.maxShadowRadius
        let rect = CGRect(x: 0, y: bounds.maxY - radius, width: bounds.width, height: radius)
        layer.shadowPath = UIBezierPath(rect: rect).cgPath
    }

    // MARK: - Shadow

    public func updateShadow(using scrollView: UIScrollView) {
        let contentFrame = CGRect(
            x: -scrollView.contentOffset.x,
            y: scrollView.frame.minY - scrollView.contentOffset.y - scrollView.contentInset.top,
            width: scrollView.contentSize.width,
            height: scrollView.contentSize.height + scrollView.contentInset.top
        )

        let intersection = contentFrame.intersection(frame)
        layer.shadowRadius = min(intersection.height * 0.2, BottomShadowView.maxShadowRadius)
        print(layer.shadowRadius)
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = .white

        layer.masksToBounds = false
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 0
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.black.cgColor
    }
}
