//
//  ViewController.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 2/18/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

#if canImport(UIKit)
import UIKit


open class SentenceViewController: BaseViewController {
    
    public let sentence = Sentence()
    public let sentenceView = SentenceView(autolayout: true)
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        sentenceView.sentence = sentence
        sentenceView.delegate = self
        
        view.addSubview(sentenceView)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateInterface()
    }
    
}

extension SentenceViewController: ControlFragmentDelegate {
    
    open func controlFragmentWillShowEditController(_ controlFragment: ControlFragment) {
        guard let editController = controlFragment.editView else { return }
        editController.style = sentenceView.style
        editController.modalPresentationStyle = .overCurrentContext
        present(editController, animated: false)
    }
    
    open func controlFragment(_ controlFragment: ControlFragment, stringDidChange string: String) {
        updateInterface()
    }
    
}
#endif
