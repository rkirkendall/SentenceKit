//
//  MultiChoiceEditView.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/6/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

open class SizableTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    override open var intrinsicContentSize: CGSize {
        let height = min(contentSize.height + 20, maxHeight)
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: height)
    }
}

open class MultiChoiceEditViewController: EditBaseController {
    
    public let tableView = SizableTableView(autolayout: true)
    open var choices:[String]?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    override open func setupConstraints() {
        super.setupConstraints()
        
        let layoutConstraints = [tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                 tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)]
        view.addConstraints(layoutConstraints)
    }
}
extension MultiChoiceEditViewController: UITableViewDataSource, UITableViewDelegate {
    
    func rowHeight() -> CGFloat {
        guard let style = self.style else { return 48 }
        
        var atts = [NSAttributedString.Key:Any]()
        atts[NSAttributedString.Key.font] = style.font
        atts[NSAttributedString.Key.foregroundColor] = style.controlColor
        
        let optAttString = NSAttributedString(string: "      ", attributes: atts)
        
        return optAttString.size().height + 6
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight()
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight()
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices?.count ?? 0
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        guard let choices = choices else { return cell }
        let optString = choices[indexPath.row]
        cell.textLabel?.text = optString
        cell.backgroundColor = .clear
        cell.textLabel?.textAlignment = .center
        
        guard let style = self.style else { return cell }
        var atts = [NSAttributedString.Key:Any]()
        atts[NSAttributedString.Key.font] = style.font
        atts[NSAttributedString.Key.foregroundColor] = style.controlColor
        let optAttString = NSAttributedString(string: optString, attributes: atts)
        cell.textLabel?.attributedText = optAttString
        
        return cell
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let choices = choices else { return }
        let optString = choices[indexPath.row]
        delegate?.editController(self, didReturnWithValue: optString)
        dismiss(animated: false, completion: nil)
    }
    
    
}
