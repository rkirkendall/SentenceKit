//
//  ViewController.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 2/18/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import UIKit

class SentenceViewController: BaseViewController {
    
    let sentence = Sentence()
    let sentenceView = SentenceView(autolayout: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sentenceView.sentence = sentence
        sentenceView.delegate = self
        
        view.addSubview(sentenceView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateInterface()
    }
    
}

extension SentenceViewController: ControlFragmentDelegate {
    
    func controlFragmentWillShowEditController(_ controlFragment: ControlFragment) {
        guard let editController = controlFragment.editView else { return }
        editController.style = sentenceView.style
        editController.modalPresentationStyle = .overCurrentContext
        present(editController, animated: false)
    }
    
    func controlFragment(_ controlFragment: ControlFragment, stringDidChange string: String) {
        updateInterface()
    }
    
}
