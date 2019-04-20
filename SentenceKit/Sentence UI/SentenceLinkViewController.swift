//
//  SentenceLinkViewController.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/19/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import UIKit
import Modernistik

class SentenceLinkViewController: ModernViewController, UITextViewDelegate {
    var textView = UITextView(autolayout: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        
        let attributedString = NSMutableAttributedString()
        let staticString = NSAttributedString(string: "Hello my name is ", attributes: [:])
        let linkString = NSAttributedString(string: "Ricky",
                                            attributes: [NSAttributedString.Key.link:"test",
                                                         NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue,
                                                         NSAttributedString.Key.foregroundColor: UIColor.red])            
        attributedString.append(staticString)
        attributedString.append(linkString)
        
        // textView.linkTextAttributes ... ohhh....
        textView.attributedText = attributedString
        textView.delegate = self
        
        view.addSubview(textView)
        
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        let v = ["textView":textView]
        var constraints = [NSLayoutConstraint]()
        constraints += "H:|[textView]|".constraints(views: v)
        constraints += "V:|-50-[textView]|".constraints(views: v)
        view.addConstraints(constraints)
    }
    
    override func updateInterface() {
        super.updateInterface()
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        print(URL.absoluteString)
        return false
    }
    
}
