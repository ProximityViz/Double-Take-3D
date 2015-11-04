//
//  ShootVC.swift
//  Double Take 3D
//
//  Created by Shawn on 9/17/15.
//  Copyright © 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit
import Photos
import Parse
import Bolts

class ShootVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker = NonRotatingUIImagePickerController()
    var imageBeingPicked = "left"
    // NOTE: photos might only stay for 30 days if using iCloud
    var leftImageLocation = ""
    var rightImageLocation = ""
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera

    }
    
    @IBAction func leftImageTapped(sender: AnyObject) {
        imageBeingPicked = "left"
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func rightImageTapped(sender: AnyObject) {
        imageBeingPicked = "right"
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func saveImage(image: UIImage, position: String) {
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({ () -> Void in
            PHAssetChangeRequest.creationRequestForAssetFromImage(image)
            }) { (success, error) -> Void in
                if success {
                    print("Success")
                    if position == "left" {
                        
                    } else if position == "right" {
                        
                    }
                } else {
                    print(error)
                }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if imageBeingPicked == "left" {
            let leftImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            leftImageView.image = leftImage
            // save image to camera roll
            saveImage(leftImage, position: imageBeingPicked)
        } else if imageBeingPicked == "right" {
            let rightImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            rightImageView.image = rightImage
            saveImage(rightImage, position: imageBeingPicked)
        }

        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveToParse() {
        
        let threeDPhoto = PFObject(className: "ThreeDPhoto")
        
//        threeDPhoto["left"] = leftImageView.image
//        threeDPhoto["right"] = rightImageView.image
        threeDPhoto["user"] = "Shawn"
        
        threeDPhoto.saveInBackgroundWithBlock { (success, error) -> Void in
            if success == true {
                print("save to parse successful")
            } else {
                print("failed to save to parse")
                print(error)
            }
        }
        
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        // segue
        
        // save image URLs
        
        saveToParse()
        
        leftImageView.image = nil
        rightImageView.image = nil
        
    }
    

}
