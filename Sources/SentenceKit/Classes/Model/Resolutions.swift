//
//  Resolutions.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/6/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation

public typealias Resolution = () -> Void
public typealias Resolutions = [Resolution]
extension Resolutions {
    public static func += (left: inout Resolutions, right: @escaping Resolution) {
        left.append(right)
    }
}
