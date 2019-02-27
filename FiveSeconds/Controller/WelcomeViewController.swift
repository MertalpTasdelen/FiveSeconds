//
//  ViewController.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 20.06.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import UIKit
import MessageUI
import AVFoundation


class WelcomeViewController: UIViewController, MFMailComposeViewControllerDelegate{

    @IBAction func btnWriteQuestion(_ sender: UIButton) {
        playSound(sender.tag)
        performSegue(withIdentifier: "writeQuestion", sender: self)
        
    }
    
    @IBAction func btnPlay(_ sender: UIButton) {
        playSound(sender.tag)
        performSegue(withIdentifier: "setForPlay", sender: self)
    }
    
    @IBAction func btnRules(_ sender: UIButton) {
        
        performSegue(withIdentifier: "rulesPage", sender: self)
        playSound(sender.tag)
    }
    
    @IBAction func btnContactUs(_ sender: UIButton) {
        playSound(sender.tag)
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        
        sendEmail()
    }
    
    var sound: AVAudioPlayer!
    var arrayOfQuestions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        
        
        let question = Question()
        question.delegate = self
        question.downloadQuestions()
        
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setForPlay" {
            let destVC = segue.destination as! NumberOfPlayerViewController
            destVC.questionDocker = arrayOfQuestions
        }
    }
    
    func sendEmail(){

        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")

            let alert = UIAlertController(title: "HATA !", message: "Mail açılırken bir sorun oluştu", preferredStyle: UIAlertController.Style.alert)
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
    
//////END OF THE CLASS DECLARATION
}

extension WelcomeViewController: QuestionProtocol {
    func questionsDownloaded(items: NSArray) {
        var questionBulk = NSArray()
        questionBulk = items
        
        for item in 0 ..< questionBulk.count {
            arrayOfQuestions.append(questionBulk[item] as! Question)
        }
        
    }
}

