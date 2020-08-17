//
//  Copyright © 2020 FINN AS. All rights reserved.
//

import FinniversKit

public struct MotorTransactionModel: MotorTransactionViewModel {
    public var title: String
    public var header: MotorTransactionHeaderViewModel?
    public var alert: MotorTransactionAlertViewModel?
    public var steps: [MotorTransactionStepViewModel]
}

public struct MotorTransactionHeaderModel: MotorTransactionHeaderViewModel {
    public var adId: String
    public var title: String?
    public var registrationNumber: String?
    public var imagePath: String?
}

public struct MotorTransactionAlertModel: MotorTransactionAlertViewModel {
    public var title: String
    public var message: String
    public var imageIdentifier: String
}

public struct MotorTransactionStepModel: MotorTransactionStepViewModel {
    public var state: MotorTransactionStepViewState
    public var style: MotorTransactionStepView.CustomStyle?
    public var main: MotorTransactionStepContentViewModel?
    public var detail: MotorTransactionStepContentViewModel?
}

public struct MotorTransactionButtonModel: MotorTransactionButtonViewModel {
    public var text: String
    public var style: String?
    public var action: String?
    public var url: String?
    public var fallbackUrl: String?

    public init(text: String, style: String? = nil, action: String? = nil, url: String? = nil, fallbackUrl: String? = nil) {
        self.text = text
        self.style = style
        self.action = action
        self.url = url
        self.fallbackUrl = fallbackUrl
    }
}

public struct MotorTransactionStepContentModel: MotorTransactionStepContentViewModel {
    public var title: String?
    /*
     If body contains a link (<a href>), the backend will assign the same content to nativeBody, but without the (<a href>) link.
     Instead the nativeButton will also be present in the payload with the action and link as an replacement.

     This is to avoid having the client render both a link and a nativeButton.

     See line 56-66 in BothPartiesConfirmedHandoverDemoViewModel.swift as an example
    */
    public var body: NSAttributedString?
    public var nativeBody: NSAttributedString?
    public var nativeButton: MotorTransactionButtonViewModel?
    public var primaryButton: MotorTransactionButtonViewModel?
}

public struct MotorTransactionDefaultData {
    private var currentSellerProcessState = 0
    private var currentBuyerProcessState = 0

    // swiftlint:disable cyclomatic_complexity
    func sellerProcessState() -> MotorTransactionViewModel {
        switch currentSellerProcessState {
        case 0:
            print("Seller process state: contract not created")
            return MotorTransactionDefaultData.ContractNotCreatedDemoViewModel
        case 1:
            print("Seller process state: contract created")
            return MotorTransactionDefaultData.ContractCreatedDemoViewModel
        case 2:
            print("Seller process state: buyer invited")
            return MotorTransactionDefaultData.BuyerInvitedDemoViewModel
        case 3:
            print("Seller process state: seller only signed")
            return MotorTransactionDefaultData.SellerOnlySignedDemoViewModel
        case 4:
            print("Seller process state: buyer only signed")
            return MotorTransactionDefaultData.BuyerOnlySignedDemoViewModel
        case 5:
            print("Seller process state: both parties signed")
            return MotorTransactionDefaultData.BothPartiesSignedDemoViewModel
        case 6:
            print("Seller process state: awaiting payment")
            return MotorTransactionDefaultData.AwaitingPaymentDemoViewModel
        case 7:
            print("Seller process state: payment completed")
            return MotorTransactionDefaultData.PaymentCompletedDemoViewModel
        case 8:
            print("Seller process state: buyer confirmed handover")
            return MotorTransactionDefaultData.BuyerConfirmedHandoverDemoViewModel
        case 9:
            print("Seller process state: seller confirmed handover")
            return MotorTransactionDefaultData.SellerConfirmedHandoverDemoViewModel
        case 10:
            print("Seller process state: payment completed - both parties confirmed handover")
            return MotorTransactionDefaultData.BothPartiesConfirmedHandoverDemoViewModel
        case 11:
            print("Seller process state: ad expired - show Nettbil integration")
            return MotorTransactionDefaultData.AdExpiredDemoViewModel
        case 12:
            print("Seller process state: payment cancelled")
            return MotorTransactionDefaultData.PaymentCancelledDemoViewModel
        default:
            fatalError("No model exists for step \(currentSellerProcessState)")
        }
    }

    mutating func getNextSellerProcessState() -> MotorTransactionViewModel {
        if currentSellerProcessState == 12 {
            self.currentSellerProcessState = -1
        }
        currentSellerProcessState += 1
        return sellerProcessState()
    }

    func buyerProcessState() -> MotorTransactionViewModel {
        switch currentBuyerProcessState {
        case 0:
            print("Buyer process state: without insurance confirmation")
            return MotorTransactionDefaultData.WithoutInsuranceConfirmationDemoViewModel
        case 1:
            print("Buyer process state: with insurance confirmation")
            return MotorTransactionDefaultData.WithInsuranceConfirmationDemoViewModel
        default:
            fatalError("No model exists for step \(currentBuyerProcessState)")
        }
    }

    mutating func getNextBuyerProcessState() -> MotorTransactionViewModel {
        if currentBuyerProcessState == 1 {
            self.currentBuyerProcessState = -1
        }
        currentBuyerProcessState += 1
        return buyerProcessState()
    }
}
