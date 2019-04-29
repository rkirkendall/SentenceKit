//
//  FreeEntry.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/26/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

class FreeEntry: ControlFragment {
    private var _editViewController = FreeEntryEditViewController()
    private var _stringValue: String?
    override var stringValue: String {
        set {
            self._stringValue = newValue
        }
        get {
            if let s = _stringValue, s.count != 0 {
                return s
            }
            return emptyPlaceholder
        }
    }
    
    override init() {
        super.init()
        _editViewController.delegate = self
        editView = _editViewController
    }
}

extension FreeEntry: EditVariableTextDelegate {
    func changeStringVariable(_ string: String) {
        _stringValue = string
        delegate?.valueDidChange(control: self, newValue: string)
    }
}
