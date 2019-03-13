//
//  SUIComponent.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

struct SUIStyleContext {
    let font: UIFont
    let controlColor: UIColor
    let textColor: UIColor
    let paragraphStyle: NSParagraphStyle
}

protocol SUIInputControlDelegate {
}

protocol SUIComponent {
    var stringValue: String {get}
    var isInput: Bool {get}
    var superview: UIView? {set get}
}

protocol SUIInputControl: SUIComponent {
    func tooWide(styleContext: SUIStyleContext, frame: CGRect) -> Bool
    func view(styleContext: SUIStyleContext, frame: CGRect) -> UIView
}; extension SUIInputControl {
    var isInput: Bool { return true }
    var arrow:String { return "▾"}
}
