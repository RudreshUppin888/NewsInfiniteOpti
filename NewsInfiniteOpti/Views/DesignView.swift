//
//  DesignView.swift
//  CardTable
//
//  Created by Rudresh Uppin on 15/10/20.
//  Copyright © 2020 Rudresh Uppin. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class DesignView: UIView{
    
    @IBInspectable var cornerRadius : CGFloat = 0
    @IBInspectable var shadowColor : UIColor? = UIColor.black
    @IBInspectable var shadowOffsetWidth : Int = 0
    @IBInspectable var shadowOffsetHeight : Int = 1
    @IBInspectable var shadowOpacity : Float = 0.5
    
    
    override func layoutSubviews() {
        
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height:shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity

        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
    
    }
    

}



