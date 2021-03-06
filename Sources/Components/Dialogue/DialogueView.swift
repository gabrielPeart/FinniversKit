//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

// MARK: - DialogueViewModel

/**
 - Note:
    Use this protocol to update Dialogue view model

 */

public protocol DialogueViewModel {
    var title: String { get }
    var detail: String { get }
    var link: String? { get }
    var primaryButtonTitle: String { get }
    var secondaryButtonTitle: String? { get }
}

// MARK: - DialogueViewDelegate

/**
 - Note:
    Protocol to call back the Dialogue view Delegate

 */

public protocol DialogueViewDelegate: AnyObject {
    func dialogueViewDidSelectLink()
    func dialogueViewDidSelectPrimaryButton()
    func dialogueViewDidSelectSecondaryButton()
}

/**
 - Note:
   Default implementation for
   Dialogue View Did Select Link
   Dialogue View Did Select Secondary Button

 */
extension DialogueViewDelegate {
    public func dialogueViewDidSelectSecondaryButton() {}
    public func dialogueViewDidSelectLink() {}
}

// MARK: - DialogueView

/**
 - Note:
 A view ment to be used as a Dialogue view
 Optional image, link and secondary button. 

 */

public class DialogueView: UIView {

    // MARK: - Subviews

    private lazy var title: UILabel = {
        let label = Label(style: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .licorice
        return label
    }()

    private lazy var detail: UILabel = {
        let label = Label(style: .caption)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .licorice
        label.numberOfLines = 0
        return label
    }()

    private lazy var link: Button = {
        let button = Button(style: .link)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLinkTap), for: .touchUpInside)
        return button
    }()

    private lazy var primaryButton: UIButton = {
        let button = Button(style: .callToAction)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePrimaryButtonTap), for: .touchUpInside)
        return button
    }()

    private lazy var secondaryButton: UIButton = {
        let button = Button(style: .flat, size: .small)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSecondaryButtonTap), for: .touchUpInside)
        return button
    }()

    // MARK: - Model

    public var model: DialogueViewModel? {
        didSet {
            title.text = model?.title
            detail.text = model?.detail
            link.setTitle(model?.link, for: .normal)
            primaryButton.setTitle(model?.primaryButtonTitle, for: .normal)
            secondaryButton.setTitle(model?.secondaryButtonTitle, for: .normal)
        }
    }

    // MARK: - Delegate

    public weak var delegate: DialogueViewDelegate?

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = .milk
        layer.cornerRadius = 8

        addSubview(title)
        addSubview(detail)
        addSubview(link)
        addSubview(primaryButton)

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: .largeSpacing),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .largeSpacing),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.largeSpacing),

            detail.topAnchor.constraint(equalTo: title.bottomAnchor, constant: .mediumSpacing),
            detail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .largeSpacing),
            detail.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.largeSpacing),

            link.topAnchor.constraint(equalTo: detail.bottomAnchor, constant: .mediumSpacing),
            link.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .largeSpacing),
            link.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.largeSpacing),

            primaryButton.topAnchor.constraint(equalTo: link.bottomAnchor, constant: .mediumLargeSpacing),
            primaryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
    }

    // MARK: - Actions

    @objc private func handlePrimaryButtonTap() {
        delegate?.dialogueViewDidSelectPrimaryButton()
    }

    @objc private func handleSecondaryButtonTap() {
        delegate?.dialogueViewDidSelectSecondaryButton()
    }

    @objc private func handleLinkTap() {
        delegate?.dialogueViewDidSelectLink()
    }
}
