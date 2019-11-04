//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import FinniversKit
import Foundation

struct AdConfirmationViewDefaultData: AdConfirmationViewModel {
    var objectViewModel: AdConfirmationObjectViewModel = AdConfirmationObjectViewModelDefaultData()
    var summaryViewModel: AdConfirmationSummaryViewModel? = AdConfirmationSummaryViewModelDefaultData()
    var feedbackViewModel: AdConfirmationFeedbackViewModel?
    var completeActionLabel = "Gå til mine annonser"
}

struct AdConfirmationObjectViewModelDefaultData: AdConfirmationObjectViewModel {
    var imageUrl: URL? = URL(string: "https://i.pinimg.com/736x/73/de/32/73de32f9e5a0db66ec7805bb7cb3f807--navy-blue-houses-blue-and-white-houses-exterior.jpg")
    var title: String = "Fiks ferdig!"
    var body: String? = "Om ett til to minutter er annosnen synlig på FINN"
}

struct AdConfirmationSummaryViewModelDefaultData: AdConfirmationSummaryViewModel {
    var title: String? = "Ditt kjøp"
    var orderLines: [String] = ["Torgetannonse"]
    var priceLabel: String = "Totalsum"
    var priceText: String? = "Gratis"
    var priceValue: Int = 100000
}