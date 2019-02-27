//
//  NumberOfPlayerViewController.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 21.06.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation




class NumberOfPlayerViewController: UIViewController, UITextFieldDelegate{
    
    var playerCount = 0
    var questionDocker = [Question]()
    var sound: AVAudioPlayer!
    
    @IBOutlet weak var txtPlayerCount: UITextField!
    
    @IBAction func btnCont(_ sender: UIButton) {
        control()
        playSound(sender.tag)
        performSegue(withIdentifier: "gameScreen", sender: self)
        //txtPlayerCount.text = ""
        
    }
    @IBAction func btnBack(_ sender: UIButton) {
        playSound(sender.tag)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        txtPlayerCount.textAlignment = .center
        txtPlayerCount.text = "\(2)"
        playerCount = 2
   
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameScreen" {
            let secondVC = segue.destination as! GameScreenViewController
            secondVC.playerCount = Int(txtPlayerCount.text!)!
            secondVC.questionContainer = questionDocker
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5){
            //textField.keyboardType = UIKeyboardType.numberPad
            self.playerCount = Int(textField.text!)!
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) { }
    }
    

    //MARK: Control for the vlaid player number
    func control(){
        if Int(txtPlayerCount.text!) == nil  || Int(txtPlayerCount.text!)! == 0 ||  Int(txtPlayerCount.text!)! == 1  {
            let alert = UIAlertController(title: "Kimse Yok Mu ?", message: "Bu oyun en az iki kişi ile oynanır", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yeniden Dene", style: .default, handler: { (action) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: "gameScreen", sender: self)
        }
    }
    
    func playSound(_ tag: Int){
        guard let url = Bundle.main.url(forResource: "chalk\(tag)", withExtension: "wav") else {return}
        
        do{
            try sound = AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        } catch let error{
            print(error.localizedDescription)
        }
        
        sound.prepareToPlay()
        sound.play()
    }

    
}
