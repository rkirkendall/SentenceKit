//
//  MultiChoiceEditView.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/6/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import Modernistik

class SizableTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}

class MultiChoiceEditView: BlurOverlay {
    
    let tableView = SizableTableView(autolayout: true)
    var choices:[String]?
    var styleContext:StyleContext?
    
    override func setupView() {
        super.setupView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        addSubview(tableView)
        
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let layoutConstraints = [tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                 tableView.centerYAnchor.constraint(equalTo: self.centerYAnchor)]
        addConstraints(layoutConstraints)
    }
}
extension MultiChoiceEditView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let choices = choices,
            let styleContext = self.styleContext else { return 48 }
        let optString = choices[indexPath.row]
        var atts = [NSAttributedString.Key:Any]()
        atts[NSAttributedString.Key.font] = styleContext.font
        atts[NSAttributedString.Key.foregroundColor] = styleContext.controlColor
        let optAttString = NSAttributedString(string: optString, attributes: atts)
        
        return optAttString.size().height + 6 // pad
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let choices = choices else { return cell }
        let optString = choices[indexPath.row]
        cell.textLabel?.text = optString
        cell.backgroundColor = .clear
        cell.textLabel?.textAlignment = .center
        
        guard let styleContext = self.styleContext else { return cell }
        var atts = [NSAttributedString.Key:Any]()
        atts[NSAttributedString.Key.font] = styleContext.font
        atts[NSAttributedString.Key.foregroundColor] = styleContext.controlColor
        let optAttString = NSAttributedString(string: optString, attributes: atts)
        cell.textLabel?.attributedText = optAttString
        
        return cell
    }
    
    
}
