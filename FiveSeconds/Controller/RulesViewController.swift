//
//  RulesViewController.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 26.06.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import Foundation
import UIKit

class RulesViewController: UIViewController{
    
    @IBAction func btnBack(_ sender: RoundedButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
