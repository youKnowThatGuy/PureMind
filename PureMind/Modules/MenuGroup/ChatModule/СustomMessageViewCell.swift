//
//  СustomMessageViewCell.swift
//  PureMind
//
//  Created by Клим on 29.09.2021.
//

import UIKit
import MessageKit

open class CustomMessageViewCell: UICollectionViewCell {
    open func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
           self.contentView.backgroundColor = lightYellowColor
       }
}

open class CustomMessageSizeCalculator: MessageSizeCalculator {
    open override func messageContainerSize(for message: MessageType) -> CGSize {
    // Customize this function implementation to size your content appropriately. This example simply returns a constant size
    // Refer to the default MessageKit cell implementations, and the Example App to see how to size a custom cell dynamically
        return CGSize(width: 300, height: 130)
    }
}

open class MyCustomMessagesFlowLayout: MessagesCollectionViewFlowLayout {
    lazy open var customMessageSizeCalculator = CustomMessageSizeCalculator(layout: self)

    override open func cellSizeCalculatorForItem(at indexPath: IndexPath) -> CellSizeCalculator {
        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        if case .custom = message.kind {
            return customMessageSizeCalculator
        }
        return super.cellSizeCalculatorForItem(at: indexPath);
    }
}
