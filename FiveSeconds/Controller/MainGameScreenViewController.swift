//
//  MainGameScreenViewController.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 28.06.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import Foundation
import UIKit


class MainGameScreenViewController : UIViewController {
    
    @IBOutlet weak var lblTimeShow: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func btnStart(_ sender: RoundedButton) {
        runTimer()
//        progressView.progress = seconds / 1.0
    }
    
    @IBAction func btnUncoverQuestion(_ sender: RoundedButton) {
        
    }
    
    var playerArray: [Player] = []
    var turn: Int = 0
    var seconds = Float(5.0)
    var timer = Timer()
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in playerArray {
            print(item.name)
        }
    }
    

    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector(MainGameScreenViewController.updateTimer)), userInfo: nil, repeats: true)
        progressView.setProgress(seconds, animated: true)
        perform(#selector(updateTimer), with: nil, afterDelay: 0.0)
    }
    
    @objc func updateTimer(){
        seconds -= 1
        lblTimeShow.text = "\(seconds)"
        if seconds == 0 {
            timer.invalidate() //stoops the timer
            lblTimeShow.text = "\(0)"
        }
    }
    
    
}
