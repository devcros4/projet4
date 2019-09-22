//
//  ViewController.swift
//  Projet4
//
//  Created by DELCROS Jean-baptiste on 09/08/2019.
//  Copyright © 2019 DELCROS Jean-baptiste. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Attribut
    @IBOutlet weak var btnLayer1: UIButton!
    @IBOutlet weak var btnLayer2: UIButton!
    @IBOutlet weak var btnLayer3: UIButton!
    @IBOutlet weak var btnLeftBottom: UIButton!
    @IBOutlet weak var btnRightBottom: UIButton!
    @IBOutlet weak var btnLeftTop: UIButton!
    @IBOutlet weak var btnRightTop: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lbSwipeInfo: UILabel!
    @IBOutlet weak var imgSwipeDirection: UIImageView!
    @IBOutlet weak var swipeGesture: UISwipeGestureRecognizer!
    
    
    
    var imagePicker: UIImagePickerController!
    
    var btnImage: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    ///
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { get { return .all } }
    
    /// change direction of gesture based on device orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.swipeGesture.direction = .left
        } else {
            self.swipeGesture.direction = .up
        }
    }
    // MARK: Actions
    
    /// display the library to choose an image
    @IBAction func choiceImage(_ sender: UIButton) {
        self.btnImage = sender
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present( imagePicker, animated:true, completion:nil )
    }
    
    @IBAction func selectLayer1(_ sender: UIButton) {
        sender.isSelected = true
        self.btnLayer2.isSelected = false
        self.btnLayer3.isSelected = false
        self.btnLeftBottom.isHidden = false
        self.btnRightBottom.isHidden = false
        self.btnLeftTop.isHidden = false
        self.btnRightTop.isHidden = true
    }
    @IBAction func selectLayer2(_ sender: UIButton) {
        sender.isSelected = true
        self.btnLayer1.isSelected = false
        self.btnLayer3.isSelected = false
        self.btnLeftTop.isHidden = false
        self.btnRightTop.isHidden = false
        self.btnLeftBottom.isHidden = false
        self.btnRightBottom.isHidden = true
    }
    @IBAction func selectLayer3(_ sender: UIButton) {
        sender.isSelected = true
        btnLayer1.isSelected = false
        btnLayer2.isSelected = false
        self.btnLeftBottom.isHidden = false
        self.btnRightBottom.isHidden = false
        self.btnLeftTop.isHidden = false
        self.btnRightTop.isHidden = false
    }
    
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        if UIDevice.current.orientation.isLandscape {
            self.moveViewHorizontally()
        } else {
            self.moveViewVertically()
        }
         self.shareImage(image: self.contentView.asImage())
    }
    // MARK: Private function
    
    /// allows to share an image
    private func shareImage(image: UIImage) {
        // set up activity view controller
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = {(UIActivityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            self.moveViewToOrigin()
        }
    }
    /// move vertically contentView outside the screen
    private func moveViewVertically() {
            UIView.animate(withDuration: 0.5) {
                self.contentView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            }
    }
    /// replace contentView in old position
    private func moveViewToOrigin() {
        UIView.animate(withDuration: 0.5) {
            self.contentView.transform = .identity
        }
    }
    /// move horizontally contentView outside the screen
    private func moveViewHorizontally() {
            UIView.animate(withDuration: 0.5) {
                self.contentView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            }
    }

}

extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    // MARK: UIImagePickerControllerDelegate
    // définition des méthodes de l'interface (protocol)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil) //  on retire le contrôleur
        
        // affichage de la photo
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                   self.btnImage.setImage(image, for: .normal)
        }
    }

    /// when canceling the selection of an image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true) {
            print("annulation")
        }
    }
}

