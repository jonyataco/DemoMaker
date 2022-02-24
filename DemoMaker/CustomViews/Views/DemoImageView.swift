//
//  DemoImageView.swift
//  DemoMaker
//
//  Created by Jonathan Yataco on 11/7/21.
//

import UIKit

class DemoImageView: UIImageView {
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        addPanGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resizeImage(inside parentView: UIView) {
        guard let image = image else {
            print("Unable to resize the image because there is no UIImage associated with the DemoImageView")
            return
        }
        
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        let parentViewWidth = parentView.frame.size.width
        
        let ratio = parentViewWidth/imageWidth
        let scaledHeight = imageHeight * ratio
        frame.size = CGSize(width: parentViewWidth, height: scaledHeight)
        centerView(inside: parentView)
    }
    
    func centerView(inside parentView: UIView) {
        center = parentView.convert(parentView.center, from: parentView.superview)
    }
    
    private func addPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        addGestureRecognizer(pan)
    }
    
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
        guard let imageView = sender.view else {
            print("Unable to handle pan gesture because the sender has no associated view")
            return
        }
    
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: imageView, sender: sender)
        case .ended:
            break
        case .cancelled:
            break
        default:
            break
        }
    }
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
}
