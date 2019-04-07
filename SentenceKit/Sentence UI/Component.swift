//
//  Component.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

class Sentence {
    var components:[Component] = [Component]()
    
    static func += (left: Sentence, right: Component) {
        left.components.append(right)
    }
}

struct StyleContext {
    let font: UIFont
    let controlColor: UIColor
    let textColor: UIColor
    let paragraphStyle: NSParagraphStyle
    let showsArrow = false
}

protocol Component {
    var stringValue: String {get}
    var isInput: Bool {get}
    var superview: UIView? {set get}
}

protocol InputControlDelegate: class {
    func showEditModal()
    func valueDidChange(control: InputControl, newValue: String)
}

protocol InputControl: Component {
    var delegate: InputControlDelegate? {get set} // should be weak
    
    func tooWide(styleContext: StyleContext, frame: CGRect) -> Bool
    func attributedString(styleContext: StyleContext) -> NSMutableAttributedString
    func view(styleContext: StyleContext, frame: CGRect) -> UIView
}; extension InputControl {
    var isInput: Bool { return true }
}

let arrow:String = "⌄"
