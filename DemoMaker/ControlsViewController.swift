//
//  ControlsViewController.swift
//  DemoMaker
//
//  Created by Jonathan Yataco  on 10/24/21.
//

import UIKit

class ControlsViewController: UIViewController, UIScrollViewDelegate {
    let controlsStack = ScrollableStackView(axis: .horizontal)

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    
    func configure() {
        view.backgroundColor = .systemBackground
        setupStack()
        addButtonsToStack()
    }
    
    private func addButtonsToStack() {
        for _ in 0..<20 {
            let image = UIImage(systemName: "pencil")
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            controlsStack.stackView.addArrangedSubview(imageView)
        }
    }
    
    func setupStack() {
        view.addSubview(controlsStack)
        controlsStack.stackView.distribution = .fillEqually
        controlsStack.stackView.spacing = 40
        // Makes it so that the stack view is horizontally scrollable
        controlsStack.backgroundColor = .gray
    
        
        NSLayoutConstraint.activate([
            controlsStack.widthAnchor.constraint(equalTo: view.widthAnchor),
            controlsStack.heightAnchor.constraint(equalToConstant: 100),
            controlsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            controlsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
