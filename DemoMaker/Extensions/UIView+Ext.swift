//
//  UIView+Ext.swift
//  DemoMaker
//
//  Created by Jonathan Yataco  on 10/24/21.
//

import UIKit

extension UIView {
    /// Adds the passed in views as subviews
    /// - Parameter views: A variable amount of subviews
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
