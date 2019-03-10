//
//  ViewController.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 2/18/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sentence: SUIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sentence += "boom"
        sentence += " it's working "
        let audience = SUIDropdown()
        audience.options = ["bitch", "friend!"]
        sentence += audience
        //sentence += "bitch!"
        //sentence.addUI()
    }


}

