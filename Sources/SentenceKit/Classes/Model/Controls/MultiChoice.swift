//
//  MultiChoice.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit

open class MultiChoice: ControlFragment {
    
    open var options: [String] {
        didSet {
            editViewController.choices = self.options
            string = options.count > 0 ? options[0] : placeholder
        }
    }
    open var editViewController = MultiChoiceEditViewController()
        
    override init() {
        options = []
        super.init()
        editViewController.choices = options
        editViewController.delegate = self
        editView = editViewController
    }
    
    required public init(tag: String) {
        options = []
        super.init(tag: tag)
        editViewController.choices = options
        editViewController.delegate = self
        editView = editViewController
    }
}

extension MultiChoice: ControlFragmentEditControllerDelegate {
    open func editController(_ editController: EditBaseController, didReturnWithValue value: String) {
        self.string = value        
    }
    
}
#endif
