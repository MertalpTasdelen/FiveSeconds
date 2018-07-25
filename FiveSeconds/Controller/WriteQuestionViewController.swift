//
//  WriteQuestionViewController.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 21.06.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import AVFoundation

class WriteQuestionViewController: UIViewController, UITextViewDelegate{
    
    // variables and declarations here
//    let DBRef = Database.database().reference().child("questions")
//    var numOfChilds: [Int] = []
    var tmpQuestion: String = ""
    lazy var realm = try! Realm()
    var sound: AVAudioPlayer!
    
    @IBOutlet weak var txtCustomQuestion: UITextView!
    
    @IBAction func btnBack(_ sender: UIButton) {
        playSound(sender.tag)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSend(_ sender: RoundedButton) {
        playSound(sender.tag)
        writeQuestion()
        txtCustomQuestion.resignFirstResponder()
    }
    
    @objc func buttonPressed(){
        txtCustomQuestion.endEditing(true)
    }

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ////// requirements for textview
        txtCustomQuestion.textAlignment = .left
        txtCustomQuestion.delegate = self
        
        let tappintCloseGesture = UITapGestureRecognizer(target: self, action: #selector(superViewTapped))
        view.addGestureRecognizer(tappintCloseGesture)
        
    }
    
    @objc func superViewTapped(){
        view.endEditing(true)
    }
    
    ////////////WRITING QUESTION
    func writeQuestion(){
        
        let newQuestion = Question()
        newQuestion.title = txtCustomQuestion.text!
        newQuestion.date = Date.init()
        
        save(question: newQuestion)
        
        txtCustomQuestion.text = ""
    }
    
    //MARK: Save the question
    
    func save(question: Question){
        do {
            try realm.write {
                 realm.add(question)
            }
        } catch {
            print("Cant write the data \(error)")
        }
        
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
    

    
    
    /////END OF THE CLASS DECLARATION
}
