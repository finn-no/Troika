//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//
import FinniversKit

public enum ComponentDemoViews: String, CaseIterable {
    case button
    case dialogue
    case easterEggButton
    case cogWheelButton
    case label
    case ribbon
    case textField
    case textView
    case toast
    case switchView
    case infobox
    case inlineConsent
    case inlineConsentV2
    case consentTransparencyInfo
    case bannerTransparencyView
    case checkbox
    case radioButton
    case roundedImageView
    case loadingIndicator
    case refreshControl
    case reviewButtonView
    case horizontalSlide
    case newYearsView
    case bottomSheetMechanics
    case feedbackView
    case happinessRating
    case earthHourView
    case klimabroletView
    case stepIndicatorView
    case nativeAdverts
    case callout
    case phaseList
    case iconCollection
    case disclaimerView
    case questionnaireView
    case tweakable
    case saveSearchView
    case identityView
    case stepSlider
    case loanCalculatorView
    case verificationView
    case panel
    case reputationView

    public static var items: [ComponentDemoViews] {
        return allCases.sorted { $0.rawValue < $1.rawValue }
    }

    public var viewController: UIViewController {
        switch self {
        case .button:
            return DemoViewController<ButtonDemoView>()
        case .dialogue:
            return DemoViewController<DialogueDemoView>()
        case .easterEggButton:
            return DemoViewController<EasterEggButtonDemoView>()
        case .reviewButtonView:
            return DemoViewController<ReviewButtonViewDemoView>()
        case .cogWheelButton:
            return DemoViewController<CogWheelButtonDemoView>()
        case .label:
            return DemoViewController<LabelDemoView>()
        case .ribbon:
            return DemoViewController<RibbonDemoView>()
        case .textField:
            return DemoViewController<TextFieldDemoView>()
        case .textView:
            return DemoViewController<TextViewDemoView>()
        case .toast:
            return DemoViewController<ToastDemoView>()
        case .switchView:
            return DemoViewController<SwitchViewDemoView>()
        case .infobox:
            return DemoViewController<InfoboxDemoView>()
        case .inlineConsent:
            return DemoViewController<InlineConsentDemoView>()
        case .inlineConsentV2:
            return InlineConsentDemoViewController()
        case .consentTransparencyInfo:
            return DemoViewController<ConsentTransparencyInfoDemoView>()
        case .bannerTransparencyView:
            return DemoViewController<BannerTransparencyDemoView>(containmentOptions: .bottomSheet)
        case .checkbox:
            return DemoViewController<CheckboxDemoView>(dismissType: .dismissButton)
        case .radioButton:
            return DemoViewController<RadioButtonDemoView>(dismissType: .dismissButton)
        case .roundedImageView:
            return DemoViewController<RoundedImageViewDemoView>()
        case .loadingIndicator:
            return DemoViewController<LoadingIndicatorViewDemoView>()
        case .refreshControl:
            return DemoViewController<RefreshControlDemoView>()
        case .horizontalSlide:
            let presentedViewController = HorizontalSlideDemoViewController()
            let secondViewController = UINavigationController(rootViewController: presentedViewController)
            secondViewController.transitioningDelegate = presentedViewController.transition
            secondViewController.modalPresentationStyle = .custom
            return secondViewController
        case .newYearsView:
            return DemoViewController<NewYearsDemoView>()
        case .bottomSheetMechanics:
            return BottomSheetMechanicsDemoViewController()
        case .feedbackView:
            return DemoViewController<FeedbackDemoView>(dismissType: .dismissButton)
        case .happinessRating:
            return DemoViewController<HappinessRatingDemoView>(dismissType: .dismissButton)
        case .earthHourView:
            return DemoViewController<EarthHourDemoView>()
        case .klimabroletView:
            return KlimabroletDemoViewController(dismissType: .none)
        case .stepIndicatorView:
            return DemoViewController<StepIndicatorDemoView>(dismissType: .dismissButton)
        case .nativeAdverts:
            return DemoViewController<NativeAdvertDemoView>(dismissType: .dismissButton)
        case .callout:
            return DemoViewController<CalloutDemoView>()
        case .phaseList:
            return DemoViewController<PhaseListDemoView>()
        case .iconCollection:
            return DemoViewController<IconCollectionDemoView>()
        case .disclaimerView:
            return DemoViewController<DisclaimerDemoView>()
        case .questionnaireView:
            return DemoViewController<QuestionnaireDemoView>()
        case .tweakable:
            return DemoViewController<TweakableDemoView>()
        case .saveSearchView:
            return SaveSearchViewDemoViewController(containmentOptions: [.bottomSheet, .navigationController])
        case .identityView:
            return DemoViewController<IdentityDemoView>()
        case .stepSlider:
            return DemoViewController<StepSliderDemoView>()
        case .verificationView:
            return DemoViewController<VerificationDemoView>()
        case .loanCalculatorView:
            return DemoViewController<LoanCalculatorDemoView>()
        case .panel:
            return DemoViewController<PanelDemoView>()
        case .reputationView:
            return DemoViewController<ReputationDemoView>()
        }
    }
}
