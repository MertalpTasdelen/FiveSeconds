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

class WriteQuestionViewController: UIViewController, UITextViewDelegate{
    
    // variables and declarations here
//    let DBRef = Database.database().reference().child("questions")
//    var numOfChilds: [Int] = []
    var tmpQuestion: String = ""
    let realm = try! Realm()
    
    
    @IBOutlet weak var txtCustomQuestion: UITextView!
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSend(_ sender: RoundedButton) {
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
    

    
    
    /////END OF THE CLASS DECLARATION
}
