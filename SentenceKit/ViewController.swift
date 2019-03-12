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
    
    let nameDropdown = SUIDropdown()
    let addressDropdown = SUIDropdown()
    let visitReasonDropdown = SUIDropdown()
    let dateDropdown = SUIDropdown()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        nameDropdown.options = ["Ricky", "Tenny"]
        addressDropdown.options = ["1755 Glendon Ave"]
        visitReasonDropdown.options = ["annual physical", "sick visit"]
        dateDropdown.options = ["Mar 13 at 4 PM"]
        
        
        sentence += nameDropdown
        sentence += " needs a doctor at "
        sentence += addressDropdown
        sentence += " for a "
        sentence += visitReasonDropdown
        sentence += " on "
        sentence += dateDropdown
        sentence += "."
    }


}

