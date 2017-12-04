//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit
import Troika

public class EmptyViewPlayground: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    public required init?(coder aDecoder: NSCoder) { fatalError() }

    private func setup() {
        let emptyView = EmptyView(withAutoLayout: true)

        emptyView.header = "Her var det stille gitt"
        emptyView.message = "Når du prater med andre på FINN, vil meldingene dine dukke opp her.\n\n Søk på noe du har lyst på, send en melding til selgeren og bli enige om en handel på én-to-tre!"

        addSubview(emptyView)
        emptyView.fillInSuperview()
    }
}
