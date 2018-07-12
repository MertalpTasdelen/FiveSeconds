//
//  MainGameScreenViewController.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 28.06.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class MainGameScreenViewController : UIViewController {
    
    //MARK: IBOutlest
    @IBOutlet weak var lblTurnSpecifier: UILabel!
    
    @IBOutlet weak var lblTimeShow: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var btnUncoverQuestion: UIButton!

    //MARK: IBActionss
    
    @IBAction func btnUncoverQuestion(_ sender: RoundedButton) {
        if btnState == 0{
            //sadece soru görünür ve buton başlata dönüşür
            btnUncoverQuestion.setTitle(questionArray?[questionNumber].title ?? "Soru yok", for: .normal)
            btnState = btnState + 1
            sender.setTitle("Başlat", for: .normal)
            sender.setTitleColor(UIColor.flatWhite, for: .normal)
            
        } else if btnState == 1 {
            
            startTimer()
            sender.setTitle("Tamam", for: .normal)
            sender.setTitleColor(UIColor.flatWhite, for: .normal)
            btnState = btnState + 1

            
        } else if btnState == 2 {
            
            stopTimer()
            let alert = UIAlertController(title: "Sizce cevap doğru mu", message: "Seçimin yap", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Doğru", style: .default, handler: { (trueAction) in
                self.playerArray[self.turn].point += 1
                self.turn += 1
                if self.playerArray.count == self.turn{
                    self.turn = 0
                }
                self.updateQuestionScreen(button: sender)
                self.btnState = 0
                self.resetTimer()
                self.lblWhoWillPlay(player: self.turn)
                self.btnUncoverQuestion.setTitle("", for: .normal)
            }))
            alert.addAction(UIAlertAction(title: "Yanlış", style: .default, handler: { (wrongAction) in
                self.turn += 1
                if self.playerArray.count == self.turn {
                    self.turn = 0
                }
                self.updateQuestionScreen(button: sender)
                self.btnState = 0
                self.resetTimer()
                self.lblWhoWillPlay(player: self.turn)
                self.btnUncoverQuestion.setTitle("", for: .normal)
                self.btnUncoverQuestion.backgroundColor = UIColor.randomFlat


            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
//    @IBAction func btnUncoverQuestionWithSwipe(_ sender: Any) {
//        btnUncoverQuestion.setTitle(questionArray?[questionNumber].title ?? "No question here", for: .normal)
//        self.updateQuestionScreen(button: sender as! UIButton)
//        turn = turn + 1
//
//    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: variables and declarations
    
    let realm = try! Realm()
    var playerArray: [Player] = [] //container for the player
    var questionArray: Results<Question>?
    var turn: Int = 0 //which player should answer the question
    var seconds = Float(5.0)
    var timer = Timer()
    var btnState = 0 //what is the state for the big button
    var isTimerRunning = false
    var questionNumber = 0 //specifies the qustion number
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialization for the first player
        btnUncoverQuestion.backgroundColor = UIColor.randomFlat
        lblWhoWillPlay(player: turn)
        loadQuestions()
//        for item in playerArray {
//            print(item.name)
//        }
        

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
    
    func resetTimer(){
        seconds = 5.0
        lblTimeShow.text = "\(seconds)"
        progressView.progress = seconds
    }
    
    func loadQuestions(){
         questionArray = realm.objects(Question.self) // pull the all questions in variable
    }
    
    func updateQuestionScreen(button: UIButton){
        button.setTitleColor(UIColor.flatWhite, for: .normal)
        button.setTitle("Kartı Aç", for: .normal)
        questionNumber += 1
    }
    
    func lblWhoWillPlay(player: Int) {
        lblTurnSpecifier.text = "Sorunun sahibi \(playerArray[player].name)"
        lblTurnSpecifier.textColor = UIColor.flatBlack
        lblTurnSpecifier.textAlignment = .center
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
