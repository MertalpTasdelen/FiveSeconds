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
    
    @IBInspectable var cornerRadius: CGFloat = 5{
        didSet{
            refreshCorner(value: cornerRadius)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2{
        didSet{
            refreshBorderWidth(value: borderWidth)
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.flatWhite{
        didSet{
            refreshBorderColor(value: borderColor)
        }
    }
    
    //For programmatically created buttons
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    //For Storyboard/.xib created buttons
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    //It's allows us for resizing the value of corner in storyboard
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit(){
        refreshCorner(value: cornerRadius)
        refreshBorderWidth(value: borderWidth)
        refreshBorderColor(value: borderColor)
    }
    
    func refreshCorner(value: CGFloat){
        layer.cornerRadius = value
    }
    
    func refreshBorderColor(value: UIColor){
        layer.borderColor = value.cgColor
    }
    
    func refreshBorderWidth(value: CGFloat){
        layer.borderWidth = value
    }
    

}
