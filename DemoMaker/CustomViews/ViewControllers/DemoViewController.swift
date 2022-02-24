//
//  DemoViewController.swift
//  DemoMaker
//
//  Created by Jonathan Yataco  on 10/17/21.
//

import UIKit
import PhotosUI
import UniformTypeIdentifiers

class DemoViewController: UIViewController {
    
    let controlsStack = ScrollableStackView(axis: .horizontal)

    let pickPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        return button
    }()
    
    let demoConatinerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let imageView = DemoImageView()
    
    override func viewDidLoad() {
        configureAppearance()
        configureUI()
        configureButtons()
    }
    
    override func viewDidLayoutSubviews() {
        imageView.center = demoConatinerView.convert(demoConatinerView.center, from: demoConatinerView.superview)
    }
    
    func configureAppearance() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        title = "New Demo"
    }
    
    func configureButtons() {
        let containerViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(containerViewTapped))
        demoConatinerView.isUserInteractionEnabled = true
        demoConatinerView.addGestureRecognizer(containerViewTapGesture)
    
        pickPhotoButton.addTarget(self, action: #selector(pickPhotoButtonPressed), for: .touchUpInside)
        controlsStack.stackView.addArrangedSubview(pickPhotoButton)
    }
    
    func configureUI() {
        view.addSubview(controlsStack)
        view.addSubview(demoConatinerView)
        view.addSubview(pickPhotoButton)
        demoConatinerView.addSubview(imageView)
        controlsStack.translatesAutoresizingMaskIntoConstraints = false
        pickPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        demoConatinerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            demoConatinerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            demoConatinerView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            demoConatinerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            demoConatinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            controlsStack.topAnchor.constraint(equalTo: demoConatinerView.bottomAnchor),
            controlsStack.widthAnchor.constraint(equalTo: view.widthAnchor),
            controlsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controlsStack.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func pickPhotoButtonPressed() {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func containerViewTapped() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = demoConatinerView.backgroundColor!
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }
}

extension DemoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // Dismiss the image picker after the user has finished selecting results
        dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self, let image = image as? UIImage else {
                        return
                    }
                    
                    self.imageView.image = image
                    self.imageView.resizeImage(inside: self.demoConatinerView)
                }
            }
        }
    }
}

// UIColorPickerDelegate Implementation
extension DemoViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        demoConatinerView.backgroundColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        demoConatinerView.backgroundColor = viewController.selectedColor
    }
}
