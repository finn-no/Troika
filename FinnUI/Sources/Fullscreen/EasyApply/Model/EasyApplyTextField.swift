//
//  Copyright © 2021 FINN.no AS. All rights reserved.
//

import SwiftUI
import FinniversKit

@available(iOS 13.0, *)
struct EasyApplyTextField: Swift.Identifiable {
    let id: UUID = UUID()
    let type: FinnTextField.Input
    let placeholder: String
    let helpText: String?
    var value: String

    init(type: FinnTextField.Input, placeholder: String, helpText: String? = nil, value: String = "") {
        self.type = type
        self.placeholder = placeholder
        self.helpText = helpText
        self.value = value
    }
}

