//
//  SentenceTextView.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/28/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

class SentenceTextView: UITextView {
    
    override var canBecomeFirstResponder: Bool { return false }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        removeLongPress()
    }
    
    private func removeLongPress() {
        if let grs = gestureRecognizers {
            for r in grs {
                if r is UILongPressGestureRecognizer {
                    r.isEnabled = false
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
