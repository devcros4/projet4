//
//  ViewController.swift
//  Projet4
//
//  Created by DELCROS Jean-baptiste on 09/08/2019.
//  Copyright © 2019 DELCROS Jean-baptiste. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnLayer1: UIButton!
    @IBOutlet weak var btnLayer2: UIButton!
    @IBOutlet weak var btnLayer3: UIButton!
    
    @IBOutlet weak var btnLargeTop: UIButton!
    @IBOutlet weak var btnLargeBottom: UIButton!
    @IBOutlet weak var btnLeftBottom: UIButton!
    @IBOutlet weak var btnRightBottom: UIButton!
    @IBOutlet weak var btnLeftTop: UIButton!
    @IBOutlet weak var btnRightTop: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lbSwipeInfo: UILabel!
    @IBOutlet weak var imgSwipeDirection: UIImageView!
    @IBOutlet weak var swipeGesture: UISwipeGestureRecognizer!
    
    
    
    // ici le contrôleur appareil photo ou album
    var imagePicker: UIImagePickerController!
    var btnImage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.swipeGesture.direction = .left
        } else {
            self.swipeGesture.direction = .up
        }
    }
    /// MARK: Actions
    @IBAction func choiceImage(_ sender: UIButton) {
        self.btnImage = sender
        imagePicker = UIImagePickerController() // création de l'instance du contrôleur
        
        imagePicker.delegate = self // recevoir les événements du composant UIImagePickerController
        
        //imagePicker.cameraOverlayView =
        
        // ici il s'agira de l'album photo
        imagePicker.sourceType = .photoLibrary
        
        // on affiche l'album
        present( imagePicker, animated:true, completion:nil )
    }
    
    @IBAction func selectLayer1(_ sender: UIButton) {
        sender.isSelected = true
        self.btnLayer2.isSelected = false
        self.btnLayer3.isSelected = false
        self.btnLargeTop.isHidden = false
        self.btnLeftBottom.isHidden = false
        self.btnRightBottom.isHidden = false
        self.btnLargeBottom.isHidden = true
        self.btnLeftTop.isHidden = true
        self.btnRightTop.isHidden = true
    }
    @IBAction func selectLayer2(_ sender: UIButton) {
        sender.isSelected = true
        self.btnLayer1.isSelected = false
        self.btnLayer3.isSelected = false
        self.btnLargeBottom.isHidden = false
        self.btnLeftTop.isHidden = false
        self.btnRightTop.isHidden = false
        self.btnLargeTop.isHidden = true
        self.btnLeftBottom.isHidden = true
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
        self.btnLargeTop.isHidden = true
        self.btnLargeBottom.isHidden = true
    }
    
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        if UIDevice.current.orientation.isLandscape {
            self.moveViewHorizontally()
        } else {
            self.moveViewVertically()
        }
         self.shareImage(image: self.contentView.asImage())
    }
    
    /// MARK: Private
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

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true) {
            print("annulation")
        }
    }
}

