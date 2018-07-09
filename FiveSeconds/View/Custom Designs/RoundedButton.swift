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
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            refreshCorners(value: cornerRadius)
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
        refreshCorners(value: cornerRadius)
    }
    
    // A helper method for updating the corner radius
    func refreshCorners(value: CGFloat){
        layer.cornerRadius = value
    }
}
