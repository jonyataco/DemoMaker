//
//  UIView+Ext.swift
//  DemoMaker
//
//  Created by Jonathan Yataco  on 10/24/21.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
