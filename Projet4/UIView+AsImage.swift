//
//  UIViewCornerRaduis.swift
//  Projet4
//
//  Created by DELCROS Jean-baptiste on 11/08/2019.
//  Copyright © 2019 DELCROS Jean-baptiste. All rights reserved.
//

import UIKit

extension UIView {
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
            }
        }
}
