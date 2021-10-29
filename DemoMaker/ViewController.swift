//
//  ViewController.swift
//  DemoMaker
//
//  Created by Jonathan Yataco  on 10/17/21.
//

import UIKit

class UserDemosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupButtons()
        // Do any additional setup after loading the view.
    }
    
    func setupAppearance() {
        view.backgroundColor = .systemBackground
        title = "Demos"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupButtons() {
        let addDemoButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDemo))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        setToolbarItems([flexButton, addDemoButton], animated: false)
        navigationController?.isToolbarHidden = false
    }
    
    @objc func addDemo() {
        navigationController?.pushViewController(ControlsViewController(), animated: true)
    }
}

