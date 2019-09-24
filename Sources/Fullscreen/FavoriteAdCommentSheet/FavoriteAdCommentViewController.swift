//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

protocol FavoriteAdCommentViewControllerDelegate: AnyObject {
    func favoriteAdCommentViewControllerDidSelectCancel(_ viewController: FavoriteAdCommentViewController)
    func favoriteAdCommentViewController(
        _ viewController: FavoriteAdCommentViewController,
        didSelectSaveComment comment: String?
    )
}

final class FavoriteAdCommentViewController: UIViewController {
    weak var delegate: FavoriteAdCommentViewControllerDelegate?

    private weak var remoteImageViewDataSource: RemoteImageViewDataSource?
    private let commentViewModel: FavoriteAdCommentViewModel
    private let adViewModel: FavoriteAdViewModel
    private let notificationCenter: NotificationCenter
    private lazy var loadingView = LoadingIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: 24, height: 24)))
    private lazy var loadingBarButton = UIBarButtonItem(customView: loadingView)

    private lazy var cancelButton = UIBarButtonItem(
        title: commentViewModel.cancelButtonText,
        style: .plain,
        target: self,
        action: #selector(handleCancelButtonTap)
    )

    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: commentViewModel.saveButtonText,
            style: .done,
            target: self,
            action: #selector(handleSaveButtonTap)
        )

        button.setTitleTextAttributes([.font: UIFont.bodyStrong])

        return button
    }()

    private lazy var shadowView = BottomShadowView(withAutoLayout: true)
    private lazy var contentView = UIView(withAutoLayout: true)

    private lazy var scrollView: UIScrollView = {
        let view = ScrollView(withAutoLayout: true)
        view.delegate = self
        return view
    }()

    private lazy var adView: FavoriteAdView = {
        let view = FavoriteAdView(withAutoLayout: true)
        view.isMoreButtonHidden = true
        view.isCommentViewHidden = true
        view.configure(with: adViewModel)
        view.remoteImageViewDataSource = remoteImageViewDataSource
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return view
    }()

    private lazy var textView: TextView = {
        let textView = TextView(withAutoLayout: true)
        textView.placeholderText = commentViewModel.placeholder
        textView.text = adViewModel.comment
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return textView
    }()

    private lazy var scrollViewBottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

    // MARK: - Init

    init(
        commentViewModel: FavoriteAdCommentViewModel,
        adViewModel: FavoriteAdViewModel,
        remoteImageViewDataSource: RemoteImageViewDataSource?,
        notificationCenter: NotificationCenter = .default
    ) {
        self.commentViewModel = commentViewModel
        self.adViewModel = adViewModel
        self.remoteImageViewDataSource = remoteImageViewDataSource
        self.notificationCenter = notificationCenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = commentViewModel.title
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton

        setup()
        saveButton.isEnabled = false

        [UIResponder.keyboardWillHideNotification, UIResponder.keyboardWillShowNotification].forEach {
            notificationCenter.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: $0, object: nil)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        adView.loadImage()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = textView.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _ = textView.resignFirstResponder()
        adView.resetContent()
    }

    // MARK: - Setup

    private func setup() {
        view.addSubview(scrollView)
        view.addSubview(shadowView)

        scrollView.addSubview(contentView)
        contentView.addSubview(adView)
        contentView.addSubview(textView)
        contentView.fillInSuperview()

        let shadowViewHeight = navigationController?.navigationBar.frame.height ?? 0

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollViewBottomConstraint,

            shadowView.topAnchor.constraint(equalTo: view.topAnchor, constant: -shadowViewHeight),
            shadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shadowView.heightAnchor.constraint(equalToConstant: shadowViewHeight),

            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            adView.topAnchor.constraint(equalTo: contentView.topAnchor),
            adView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            adView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            textView.topAnchor.constraint(equalTo: adView.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumLargeSpacing),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumLargeSpacing),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 86),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.mediumLargeSpacing)
        ])

        updateScrollViewConstraint(withKeyboardVisible: false, keyboardOffset: 0)
    }

    // MARK: - Keyboard

    @objc private func handleKeyboardNotification(_ notification: Notification) {
        guard let keyboardInfo = KeyboardNotificationInfo(notification) else { return }

        let keyboardVisible = keyboardInfo.action == .willShow
        let keyboardIntersection = keyboardInfo.keyboardFrameEndIntersectHeight(inView: view)

        UIView.animateAlongsideKeyboard(keyboardInfo: keyboardInfo, animations: { [weak self] in
            guard let self = self else { return }

            self.updateScrollViewConstraint(withKeyboardVisible: keyboardVisible, keyboardOffset: keyboardIntersection)
            self.view.layoutIfNeeded()
            self.shadowView.updateShadow(using: self.scrollView)
        })
    }

    private func updateScrollViewConstraint(withKeyboardVisible keyboardVisible: Bool, keyboardOffset: CGFloat) {
        let offset = keyboardOffset + view.windowSafeAreaInsets.bottom
        scrollViewBottomConstraint.constant = -offset
    }

    // MARK: - Actions

    @objc private func handleCancelButtonTap() {
        delegate?.favoriteAdCommentViewControllerDidSelectCancel(self)
    }

    @objc private func handleSaveButtonTap() {
        textView.endEditing(true)
        delegate?.favoriteAdCommentViewController(self, didSelectSaveComment: textView.text)
    }

    // MARK: - Public methods

    public func startLoading() {
        loadingView.startAnimating()
        navigationItem.setRightBarButton(loadingBarButton, animated: true)
        cancelButton.isEnabled = false
    }

    public func stopLoading() {
        loadingView.stopAnimating()
        navigationItem.setRightBarButton(saveButton, animated: true)
        cancelButton.isEnabled = true
    }
}

// MARK: - UIScrollViewDelegate

extension FavoriteAdCommentViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        shadowView.updateShadow(using: scrollView)
    }
}

// MARK: - TextViewDelegate

extension FavoriteAdCommentViewController: TextViewDelegate {
    func textViewDidChange(_ textView: TextView) {
        saveButton.isEnabled = textView.text != adViewModel.comment
    }
}

// MARK: - Private extensions

private final class ScrollView: UIScrollView {
    override var contentSize: CGSize {
        didSet {
            scrollToBottom()
        }
    }

    private func scrollToBottom() {
        let yOffset = contentSize.height - bounds.size.height + contentInset.bottom
        setContentOffset(CGPoint(x: 0, y: yOffset), animated: false)
    }
}
