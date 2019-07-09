//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import FinniversKit

enum MapTypes: Int, CaseIterable {
    case map
    case satellite
    case hybrid

    var value: String {
        switch self {
        case .map: return "Kart"
        case .satellite: return "Flyfoto"
        case .hybrid: return "Hybrid"
        }
    }
}

public struct AddressViewDefaultData: AddressViewModel {
    public var mapTypes: [String] {
        return MapTypes.allCases.map { $0.value }
    }
    public var selectedMapMode = 0
    public var address = "Vadmyrveien 18"
    public var postalCode = "5172 Loddefjord"
    public var secondaryActionTitle = "Kopier adresse"
    public var primaryActionTitle = "Åpne veibeskrivelse"

    public init() {}
}

public class AddressViewDemoView: UIView {
    private lazy var addressView: AddressView = {
        let addressView = AddressView()
        addressView.delegate = self
        addressView.translatesAutoresizingMaskIntoConstraints = false
        return addressView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    public required init?(coder aDecoder: NSCoder) { fatalError() }

    private func setup() {
        addressView.model = AddressViewDefaultData()

        addSubview(addressView)

        NSLayoutConstraint.activate([
            addressView.topAnchor.constraint(equalTo: topAnchor),
            addressView.bottomAnchor.constraint(equalTo: bottomAnchor),
            addressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            addressView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension AddressViewDemoView: AddressViewDelegate {
    public func addressViewDidSelectCopyButton(_ addressView: AddressView) {
        print("addressViewDidSelectCopyButton")
    }

    public func addressViewDidSelectGetDirectionsButton(_ addressView: AddressView) {
        print("addressViewDidSelectGetDirectionsButton")
    }

    public func addressView(_ addressView: AddressView, didSelectMapTypeAtIndex index: Int) {
        print("didSelectMapTypeAtIndex: \(MapTypes(rawValue: index)?.value ?? "None")")
    }
}
