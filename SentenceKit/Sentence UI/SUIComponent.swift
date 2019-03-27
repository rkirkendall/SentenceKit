//
//  SUIComponent.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

class SUISentence {
    var components:[SUIComponent] = [SUIComponent]()
    
    static func += (left: SUISentence, right: SUIComponent) {
        left.components.append(right)
    }
}

struct SUIStyleContext {
    let font: UIFont
    let controlColor: UIColor
    let textColor: UIColor
    let paragraphStyle: NSParagraphStyle
}

protocol SUIComponent {
    var stringValue: String {get}
    var isInput: Bool {get}
    var superview: UIView? {set get}
}

protocol SUIInputControlDelegate {}
protocol SUIInputControl: SUIComponent {
    func tooWide(styleContext: SUIStyleContext, frame: CGRect) -> Bool
    func attributedString(styleContext: SUIStyleContext) -> NSMutableAttributedString
    func view(styleContext: SUIStyleContext, frame: CGRect) -> UIView
}; extension SUIInputControl {
    var isInput: Bool { return true }
    
}

let arrow:String = "⌄"
