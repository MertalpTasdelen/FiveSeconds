//
//  MainGameScreenViewController.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 28.06.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import UIKit
import RealmSwift


class MainGameScreenViewController : UIViewController {
    
    //MARK: IBOutlest
    @IBOutlet weak var lblTimeShow: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var btnUncoverQuestion: UIButton!
    
    
    //MARK: IBActionss
//    @IBAction func btnDone(_ sender: RoundedButton) {
//   
//    }
//    
//    @IBAction func btnStart(_ sender: RoundedButton) {
//
//    }
    
    @IBAction func btnUncoverQuestion(_ sender: RoundedButton) {
        btnUncoverQuestion.setTitle(questionArray?[questionNumber].title ?? "No question here", for: .normal)
        btnState = btnState + 1
        if btnState == 1 {
            sender.setTitle("Başlat", for: .normal)
            sender.setTitleColor(UIColor.flatWhite, for: .normal)
            //Can't handle the button press identifier and dont forget the progressview while switching the button stages
            startTimer()
            btnState += 1
            if btnState == 2 {
                btnState = 0
                sender.setTitle("Tamam", for: .normal)
                sender.setTitleColor(UIColor.flatWhite, for: .normal)
                stopTimer()
                let alert = UIAlertController(title: "Sizce cevap doğru mu", message: "Seçimin yap", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Doğru", style: .default, handler: { (trueAction) in
                    self.playerArray[self.turn].point += 1
                    self.turn += 1
                    self.updateQuestionScreen(button: sender)
                }))
                alert.addAction(UIAlertAction(title: "Yanlış", style: .default, handler: { (wrongAction) in
                    self.turn += 1
                    self.updateQuestionScreen(button: sender)
                }))
            }
        }
//        turn = turn + 1
    }
    
    @IBAction func btnUncoverQuestionWithSwipe(_ sender: Any) {
        btnUncoverQuestion.setTitle(questionArray?[questionNumber].title ?? "No question here", for: .normal)
//        turn = turn + 1

    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: variables and declarations
    
    let realm = try! Realm()
    var playerArray: [Player] = []
    var questionArray: Results<Question>?
    var turn: Int = 0
    var seconds = Float(5.0)
    var timer = Timer()
    var btnState = 0
    var isTimerRunning = false
    var questionNumber = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for item in playerArray {
            print(item.name)
        }
        
        loadQuestions()
    }
    
    //MARK: Start the timer
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector(MainGameScreenViewController.updateTimer)), userInfo: nil, repeats: true)
        progressView.setProgress(seconds, animated: true)
        perform(#selector(updateTimer), with: nil, afterDelay: 0.0)
        isTimerRunning = true
    }
    
    @objc func updateTimer(){
        seconds -= 1
        lblTimeShow.text = "\(seconds)"
        if seconds == 0 {
            timer.invalidate() //stoops the timer
            lblTimeShow.text = "\(0)"
        }
    }
    
    //MARK: Stop the timer
    func stopTimer(){
        if isTimerRunning == true{
            timer.invalidate()
            isTimerRunning = false
        }
    }
    
    func loadQuestions(){
         questionArray = realm.objects(Question.self) // pull the all questions in variable
    }
    
    func updateQuestionScreen(button: UIButton){
        button.setTitleColor(UIColor.flatWhite, for: .normal)
        button.setTitle("Soru için tıkla", for: .normal)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
