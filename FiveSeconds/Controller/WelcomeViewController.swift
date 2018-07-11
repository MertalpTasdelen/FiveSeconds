//
//  ViewController.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 20.06.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import UIKit
import MessageUI


class WelcomeViewController: UIViewController, MFMailComposeViewControllerDelegate{

    @IBAction func btnWriteQuestion(_ sender: UIButton) {
        performSegue(withIdentifier: "writeQuestion", sender: self)
        
    }
    
    @IBAction func btnPlay(_ sender: UIButton) {
        performSegue(withIdentifier: "setForPlay", sender: self)
    }
    
    @IBAction func btnRules(_ sender: UIButton) {
        performSegue(withIdentifier: "rulesPage", sender: self)
    }
    
    @IBAction func btnContactUs(_ sender: UIButton) {
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        
        sendEmail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func sendEmail(){

        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")

            let alert = UIAlertController(title: "HATA !", message: "Mail açılırken bir sorun oluştu", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yeniden Dene", style: .default, handler: { (action) in
                
            }))
            self.present(alert, animated: true, completion: nil)// hatadan sonra gösterilecek ekran oradaki mail
            return
        }
        
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        
        mail.setToRecipients(["alptasdelen@hotmail.com"])
        mail.setSubject("Oyundaki bir hata")
        mail.setMessageBody("<b>Probleminizi bizimle paylaşın<b>", isHTML: true)
            
        self.present(mail, animated: true)
        
        
        
        
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
//////END OF THE CLASS DECLARATION
}

