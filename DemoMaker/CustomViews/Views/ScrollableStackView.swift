//
//  ScrollableStackView.swift
//  DemoMaker
//
//  Created by Jonathan Yataco on 10/29/21.
//

import UIKit

/// Reusuable view that manages a scrollable stack of views
class ScrollableStackView: UIView {
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    init(axis: NSLayoutConstraint.Axis) {
        super.init(frame: .zero)
        configure()
        setAxis(axis)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    /// Sets the axis/direction of the scrollable stack view
    func setAxis(_ axis: NSLayoutConstraint.Axis) {
        if axis == .horizontal {
            stackView.axis = .horizontal
            // Deactive the previous width anchor constraint if there was one
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = false
            // Makes it so that the stack is only scrollable horizontally
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        } else {
            stackView.axis = .vertical
            // Deactive the previous height anchor constraint if there was one
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = false
            // Makes it so that the stack is only scrollable vertically
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }
    }
}
