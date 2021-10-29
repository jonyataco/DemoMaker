//
//  DemoViewController.swift
//  DemoMaker
//
//  Created by Jonathan Yataco  on 10/17/21.
//

import UIKit
import UniformTypeIdentifiers

class DemoViewController: UIViewController {

    let pickPhotoButton = UIButton(type: .system)
    
    let demoConatinerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    var imageView: UIImageView? = nil
    
    override func viewDidLoad() {
        configureAppearance()
        configureButtons()
        configureUI()
    }
    
    func configureAppearance() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        title = "New Demo"
    }
    
    func configureButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Audio", image: nil, primaryAction: UIAction { [weak self] _ in
            guard let self = self else {
                return
            }
            
            let types: [UTType] = [.mp3, .wav, .aiff]
            let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: types)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false
            self.present(documentPicker, animated: true)
        })
        
        let containerViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(containerViewTapped))
        demoConatinerView.isUserInteractionEnabled = true
        demoConatinerView.addGestureRecognizer(containerViewTapGesture)
    
        pickPhotoButton.setTitle("Choose an image", for: .normal)
        pickPhotoButton.addTarget(self, action: #selector(pickPhotoButtonPressed), for: .touchUpInside)
    }
    
    func configureUI() {
        // view.addSubview(pickPhotoButton)
        view.addSubview(demoConatinerView)
        pickPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        demoConatinerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            demoConatinerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            demoConatinerView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            demoConatinerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            demoConatinerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func pickPhotoButtonPressed() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
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

// UIImagePickerControllerDelegate implementation
extension DemoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        if let image = info[.editedImage] as? UIImage {
            print("Got the edited image")
            imageView?.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

// UIDocumentPickerDelegate Implementation
extension DemoViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("The document picker was cancelled")
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let _ = urls.first else {
            print("Unable to access the picked document")
            return
        }
    
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
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
