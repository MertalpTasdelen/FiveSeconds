//
//  DesignableTextField.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 3.07.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import UIKit


@IBDesignable
class DesignableTextField: UITextField {
    
    @IBInspectable var leftImage: UIImage! {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0{
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        leftViewMode = .always
        
        let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 15, height: 15))
        imageView.image = #imageLiteral(resourceName: "user")
        
        //var width = leftPadding + 15
        
        leftView = imageView
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
