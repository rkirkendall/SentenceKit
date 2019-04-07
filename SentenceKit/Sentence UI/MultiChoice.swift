//
//  MultiChoice.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

class MultiChoice: NSObject, InputControl {

    weak var delegate: InputControlDelegate?
    weak var superview:UIView? // marked for removal
    var styleContext:StyleContext?
    var options: [String] = [String]()
    private var _editViewController = MultiChoiceEditViewController()
    var editView: EditBaseController {
        get {
            _editViewController.choices = options
            return _editViewController
        }
    }
    var stringValue:String {
        return options.count > 0 ? options[0] : "    "
    }
    var isInput: Bool {
        return true
    }
    
    private var optionsShowing = false
    private var button: UIButton?
    private var optionsView: UIView?
    private var optionsTableView: UITableView?
    
    func tooWide(styleContext: StyleContext, frame: CGRect) -> Bool {
        let button = view(styleContext: styleContext, frame: frame) as? UIButton
        return button?.titleIsTruncated ?? false
    }
    
    func attributedString(styleContext: StyleContext) -> NSMutableAttributedString {
        self.styleContext = styleContext
        var attributes = [NSAttributedString.Key:Any]()
        attributes[NSAttributedString.Key.font] = styleContext.font
        attributes[NSAttributedString.Key.underlineStyle] =  NSUnderlineStyle.single.rawValue
        attributes[NSAttributedString.Key.foregroundColor] = styleContext.controlColor
        let attString = NSMutableAttributedString(string: stringValue, attributes: attributes)
        // construct arrow att string and append
        if styleContext.showsArrow {
            let arrowFontSize = CGFloat(styleContext.font.pointSize * 0.7)
            let blueArrowAtts = [NSAttributedString.Key.foregroundColor: styleContext.controlColor,
                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: arrowFontSize),
                                 NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
            attString.append(NSAttributedString(string: arrow, attributes: blueArrowAtts))
        }
        
        return attString
    }
    
    func view(styleContext: StyleContext, frame: CGRect) -> UIView {
        let button = UIButton(frame: frame)
        let attButtonTitle = attributedString(styleContext: styleContext)
        button.setAttributedTitle(attButtonTitle, for: .normal)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.button = button
        return button
    }
    
    @objc func buttonTapped(){
        delegate?.showEditModal(control: self)
    }
}
