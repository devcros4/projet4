//
//  UIView+CornerRaduis.swift
//  Projet4
//
//  Created by Jean-Baptiste DELCROS on 20/08/2019.
//  Copyright © 2019 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

