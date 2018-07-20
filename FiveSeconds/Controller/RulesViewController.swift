//
//  RulesViewController.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 26.06.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class RulesViewController: UIViewController{
    
    var sound: AVAudioPlayer!
    
    @IBAction func btnBack(_ sender: RoundedButton) {
        playSound(sender.tag)
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func playSound(_ tag: Int){
        
        guard let url = Bundle.main.url(forResource: "chalk\(tag)", withExtension: "wav") else {return}
        
        do {
            try sound = AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        } catch let error {
            print(error.localizedDescription)
        }
        
        sound.prepareToPlay()
        sound.play()
    }
    
    
    
}
