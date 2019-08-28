//
//  Copyright © 2019 FINN AS. All rights reserved.
//

public struct FavoriteNoteViewModel {
    public let title: String?
    public let note: String
    public let notePlaceholder: String?
    public let cancelButtonText: String
    public let saveButtonText: String

    // MARK: - Init

    public init(title: String, note: String, notePlaceholder: String?, cancelButtonText: String, saveButtonText: String) {
        self.title = title
        self.note = note
        self.notePlaceholder = notePlaceholder
        self.cancelButtonText = cancelButtonText
        self.saveButtonText = saveButtonText
    }
}
