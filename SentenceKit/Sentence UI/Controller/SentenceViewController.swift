//
//  ViewController.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 2/18/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import UIKit
import Modernistik

class SentenceViewController: ModernViewController {
    
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
    
    func showEditModal(control: ControlFragment) {
        guard let editVC = control.editView else { return }
        editVC.style = sentenceView.style
        editVC.modalPresentationStyle = .overCurrentContext
        present(editVC, animated: false)
    }
    
    func valueDidChange(control: ControlFragment, newValue: String) {
        updateInterface()
    }
}
