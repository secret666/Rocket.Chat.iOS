//
//  ChatControllerMessageActions.swift
//  Rocket.Chat
//
//  Created by Rafael Kellermann Streit on 14/02/17.
//  Copyright © 2017 Rocket.Chat. All rights reserved.
//

import UIKit

extension ChatViewController {

    func presentActionsFor(_ message: Message, view: UIView) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: localized("chat.message.actions.report"), style: .default, handler: { (_) in
            self.report(message: message)
        }))

        alert.addAction(UIAlertAction(title: localized("chat.message.actions.block"), style: .default, handler: { [weak self] (_) in
            guard let user = message.user else { return }

            DispatchQueue.main.async {
                MessageManager.blockMessagesFrom(user, completion: {
                    self?.updateSubscriptionInfo()
                })
            }
        }))

        alert.addAction(UIAlertAction(title: localized("chat.message.actions.copy"), style: .default, handler: { (_) in
            UIPasteboard.general.string = message.text
        }))

        alert.addAction(UIAlertAction(title: localized("global.cancel"), style: .cancel, handler: nil))

        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = view
            presenter.sourceRect = view.bounds
        }

        present(alert, animated: true, completion: nil)
    }

    // MARK: Actions

    fileprivate func report(message: Message) {
        MessageManager.report(message) { (_) in
            let alert = UIAlertController(
                title: localized("chat.message.report.success.title"),
                message: localized("chat.message.report.success.message"),
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: localized("global.ok"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
