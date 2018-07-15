//
//  NumberOfPlayerViewController.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 21.06.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import Foundation
import UIKit

var playerCount : Int  = 0


class NumberOfPlayerViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var txtPlayerCount: UITextField!
    
    @IBAction func btnCont(_ sender: UIButton) {
        control()
        
        performSegue(withIdentifier: "gameScreen", sender: self)
        //txtPlayerCount.text = ""
        
    }
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPlayerCount.textAlignment = .center
   
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameScreen" {
            let secondVC = segue.destination as! GameScreenViewController
            
            secondVC.playerCount = Int(txtPlayerCount.text!)!
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5){
            //textField.keyboardType = UIKeyboardType.numberPad
            playerCount = Int(textField.text!)!
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) { }
    }
    

    //MARK: Control for the vlaid player number
    func control(){
        if (txtPlayerCount.text?.isEmpty) == true  || Int(txtPlayerCount.text!)! == 0 ||  Int(txtPlayerCount.text!)! == 1  {
            let alert = UIAlertController(title: "Kimse Yok Mu ?", message: "Bu oyun en az iki kişi ile oynanır", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yeniden Dene", style: .default, handler: { (action) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: "gameScreen", sender: self)
        }
    }

    
}
