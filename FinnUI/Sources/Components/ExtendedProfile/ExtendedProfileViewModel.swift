//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Foundation

public struct ExtendedProfileViewModel {
    public let headerImageUrl: String?
    public let footerImageUrl: String?

    public let sloganText: String
    public let linkTitles: [String]
    public let actionButtonTitle: String?

    public let headerBackgroundColor: UIColor
    public let sloganBackgroundColor: UIColor
    public let sloganTextColor: UIColor
    public let mainBackgroundColor: UIColor
    public let mainTextColor: UIColor

    public init(
        headerImageUrl: String?,
        footerImageUrl: String?,
        sloganText: String,
        linkTitles: [String],
        actionButtonTitle: String?,
        headerBackgroundColor: UIColor,
        sloganTextColor: UIColor,
        sloganBackgroundColor: UIColor,
        mainBackgroundColor: UIColor,
        mainTextColor: UIColor
    ) {
        self.headerImageUrl = headerImageUrl
        self.footerImageUrl = footerImageUrl
        self.sloganText = sloganText
        self.linkTitles = linkTitles
        self.actionButtonTitle = actionButtonTitle
        self.headerBackgroundColor = headerBackgroundColor
        self.sloganTextColor = sloganTextColor
        self.sloganBackgroundColor = sloganBackgroundColor
        self.mainBackgroundColor = mainBackgroundColor
        self.mainTextColor = mainTextColor
    }
}
