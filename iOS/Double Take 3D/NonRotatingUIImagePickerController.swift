//
//  NonRotatingUIImagePickerController.swift
//  Double Take 3D
//
//  Created by Shawn on 9/17/15.
//  Copyright © 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

class NonRotatingUIImagePickerController: UIImagePickerController {
    
    override func shouldAutorotate() -> Bool {
        return false
    }

}
