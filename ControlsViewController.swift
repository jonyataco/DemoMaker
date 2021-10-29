//
//  ControlsViewController.swift
//  DemoMaker
//
//  Created by Jonathan Yataco  on 10/24/21.
//

import UIKit

class ControlsViewController: UIViewController, UIScrollViewDelegate {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    
    func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(buttonStack)
        addButtonsToStack()
        setupConstraints()
    }
    
    func addButtonsToStack() {
        for i in 0..<5 {
            let button = UIButton()
            button.setTitle("Button \(i)", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            buttonStack.addArrangedSubview(button)
            print("AddedButton")
        }
    }
    
    func setupConstraints() {
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonStack.widthAnchor.constraint(equalTo: view.widthAnchor),
            buttonStack.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
