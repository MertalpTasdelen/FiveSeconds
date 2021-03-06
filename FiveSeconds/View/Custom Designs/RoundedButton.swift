//
//  RoundedButton.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 21.06.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//


import UIKit

@IBDesignable class RoundedButton: UIButton
{
    
    //initial value of rounded buttons it can be rearrage via story board
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    //initial value of rounded buttons it can be rearrage via story board

    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            refreshBorderWidth(value: borderWidth)
        }
    }
    
    //initial value of rounded buttons it can be rearrage via story board

    @IBInspectable var borderColor: UIColor = UIColor.flatWhite {
        didSet{
            refresBorderColor(value: borderColor)
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

    //It's init values  when you add the button in stroy board
    func sharedInit(){
        refreshCorners(value: cornerRadius)
        refreshBorderWidth(value: borderWidth)
        refresBorderColor(value: borderColor)
    }
    
    // A helper method for updating the corner radius
    func refreshCorners(value: CGFloat){
        layer.cornerRadius = value
    }
    
    // A helper method for updating the border width
    func refreshBorderWidth(value: CGFloat){
        layer.borderWidth = value
    }
    
    // A helper method for updating the border color
    func refresBorderColor(value: UIColor){
        layer.borderColor = value.cgColor
    }
}
