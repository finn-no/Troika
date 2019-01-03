//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

// Generated by generate_image_assets_symbols as a "Run Script" Build Phase
// WARNING: This file is autogenerated, do not modify by hand

import UIKit

public extension UIImage {
    public convenience init(named imageAsset: FinniversImageAsset) {
        self.init(named: imageAsset.rawValue, in: FinniversKit.bundle, compatibleWith: nil)!
    }

    @objc public class func assetNamed(_ assetName: String) -> UIImage {
        return UIImage(named: assetName, in: FinniversKit.bundle, compatibleWith: nil)!
    }
}

public enum FinniversImageAsset: String {
    case arrowDown
    case arrowRight
    case arrowUp
    case attachment
    case balloon0
    case balloon1
    case balloon2
    case balloon9
    case blockUser
    case boat
    case calendar
    case camera
    case candyCane
    case car
    case check
    case checkmarkBig
    case classifieds
    case distance
    case download
    case easterEgg
    case edit
    case editBig
    case error
    case favoriteAdd
    case favouriteAddImg
    case favouriteAdded
    case favouriteAddedImg
    case favourites
    case finnLogo
    case gallery
    case giftRoundedRectRed
    case giftSquarePink
    case giftSquareYellow
    case giftTriangleGreen
    case gridView
    case help
    case hide
    case home
    case important
    case info
    case jobs
    case listView
    case mapDirections
    case mapDrawarea
    case mapMyposition
    case mc
    case messages
    case minus
    case miscLike
    case miscLiked
    case miscMoney
    case mittanbud
    case more
    case moreImg
    case moteplassen
    case noImage
    case notifications
    case onlyNew
    case ornamentCircleBlue
    case ornamentCircleRed
    case ornamentStar
    case pin
    case plus
    case profile
    case rate
    case rated
    case ratings
    case realestate
    case remove
    case search
    case searchBig
    case send
    case settings
    case share
    case shopping
    case smalljobs
    case snowflake
    case sold
    case spark
    case spidLogo
    case success
    case trashcan
    case travel
    case vehicles
    case verified
    case view
    case webview
    case yourads

    public static var imageNames: [FinniversImageAsset] {
        return [
            .arrowDown,
            .arrowRight,
            .arrowUp,
            .attachment,
            .balloon0,
            .balloon1,
            .balloon2,
            .balloon9,
            .blockUser,
            .boat,
            .calendar,
            .camera,
            .candyCane,
            .car,
            .check,
            .checkmarkBig,
            .classifieds,
            .distance,
            .download,
            .easterEgg,
            .edit,
            .editBig,
            .error,
            .favoriteAdd,
            .favouriteAddImg,
            .favouriteAdded,
            .favouriteAddedImg,
            .favourites,
            .finnLogo,
            .gallery,
            .giftRoundedRectRed,
            .giftSquarePink,
            .giftSquareYellow,
            .giftTriangleGreen,
            .gridView,
            .help,
            .hide,
            .home,
            .important,
            .info,
            .jobs,
            .listView,
            .mapDirections,
            .mapDrawarea,
            .mapMyposition,
            .mc,
            .messages,
            .minus,
            .miscLike,
            .miscLiked,
            .miscMoney,
            .mittanbud,
            .more,
            .moreImg,
            .moteplassen,
            .noImage,
            .notifications,
            .onlyNew,
            .ornamentCircleBlue,
            .ornamentCircleRed,
            .ornamentStar,
            .pin,
            .plus,
            .profile,
            .rate,
            .rated,
            .ratings,
            .realestate,
            .remove,
            .search,
            .searchBig,
            .send,
            .settings,
            .share,
            .shopping,
            .smalljobs,
            .snowflake,
            .sold,
            .spark,
            .spidLogo,
            .success,
            .trashcan,
            .travel,
            .vehicles,
            .verified,
            .view,
            .webview,
            .yourads,
    ]
  }
}
