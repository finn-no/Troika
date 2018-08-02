//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Foundation
import UIKit

class ReviewTextHeader: UITableViewHeaderFooterView {
    static let identifier = "ReviewTextCell"

    lazy var title: Label = {
        let label = Label(style: Label.Style.title3)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var subTitle: Label = {
        let label = Label(style: Label.Style.body(.stone))
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white

        contentView.addSubview(title)
        contentView.addSubview(subTitle)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),
            subTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            subTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .mediumSpacing),
            title.bottomAnchor.constraint(equalTo: subTitle.topAnchor, constant: -.mediumSpacing),
            subTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.mediumSpacing),
        ])
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        subTitle.text = ""
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
