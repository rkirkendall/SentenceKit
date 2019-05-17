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
    private var editViewController = FreeEntryEditViewController()
    
    
    override var alias: String? {
        get {
            if let a = super.alias,
                a.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                return a
            }
            return placeholder
        }
        set { super.alias = newValue }
    }
    
    override init() {
        super.init()
        editViewController.delegate = self
        editView = editViewController
    }
    
    required public init(tag: String) {
        super.init(tag: tag)
        editViewController.delegate = self
        editView = editViewController
    }
}

extension FreeEntry: EditVariableTextDelegate {
    func changeStringVariable(_ string: String) {
        self.string = string
        delegate?.controlFragment(self, stringDidChange: string)        
    }
}
