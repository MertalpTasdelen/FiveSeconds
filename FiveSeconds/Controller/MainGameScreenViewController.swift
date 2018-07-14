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
    
    @IBOutlet weak var btnUncoverQuestion: UIButton!

    @IBOutlet weak var btnProgressView: RoundedButton!
    //MARK: IBActionss
    
    @IBAction func btnUncoverQuestion(_ sender: RoundedButton) {
        if btnState == 0{
            //sadece soru görünür ve buton başlata dönüşür
            btnUncoverQuestion.setTitle(questionArray?[questionNumber].title ?? "Soru yok", for: .normal)
            btnState = btnState + 1
            sender.setTitle("Başlat", for: .normal)
            sender.setTitleColor(UIColor.flatWhite, for: .normal)
//            proggressViewStart()

        } else if btnState == 1 {

            startTimer()
            sender.setTitle("Tamam", for: .normal)
            sender.setTitleColor(UIColor.flatWhite, for: .normal)
            btnState = btnState + 1
            
            if seconds == 1 || seconds == 1.00 || seconds == 1.0 {
                timer.invalidate() //stoops the timer
                lblTimeShow.text = "\(0)"
            }
            
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
                self.lblWhoWillPlay(playerTurn: self.turn)
                self.btnUncoverQuestion.setTitle("", for: .normal)
                self.btnUncoverQuestion.backgroundColor = UIColor.randomFlat
            }))
            alert.addAction(UIAlertAction(title: "Yanlış", style: .default, handler: { (wrongAction) in
                self.turn += 1
                if self.playerArray.count == self.turn {
                    self.turn = 0
                }
                self.updateQuestionScreen(button: sender)
                self.btnState = 0
                self.resetTimer()
                self.lblWhoWillPlay(playerTurn: self.turn)
                self.btnUncoverQuestion.setTitle("", for: .normal)
                self.btnUncoverQuestion.backgroundColor = UIColor.randomFlat
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: variables and declarations
    
    let realm = try! Realm()
    var playerArray: [Player] = [] //container for the player
    var questionArray: Results<Question>?
    var turn: Int = 0 //which player should answer the question
    let totalSeconds = Float(5.00)
    var seconds = Float(5.00)
    var timer = Timer()
    var btnState = 0 //what is the state for the big button
    var isTimerRunning = false
    var questionNumber = 0 //specifies the qustion number
    
    //MARK: For the progress view declerations
    let shapeLayer = CAShapeLayer()
    let ghostLayer = CAShapeLayer()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialization for the first player
        btnUncoverQuestion.backgroundColor = UIColor.randomFlat
        lblWhoWillPlay(playerTurn: turn)
        loadQuestions()
        ghostCircle()
       
    }
    
    func ghostCircle(){
//        let center = view.center
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 75.0, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        ghostLayer.path = circularPath.cgPath
        
        ghostLayer.lineWidth = 7
        ghostLayer.strokeColor = UIColor.flatGrayDark.cgColor
        ghostLayer.lineCap = kCALineCapRound
        ghostLayer.fillColor = UIColor.clear.cgColor
        ghostLayer.position = view.center
        view.layer.addSublayer(ghostLayer)
    }
    
    func proggressViewStart(){
//        let center = view.center
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 75.0, startAngle:0, endAngle: 2 * CGFloat.pi, clockwise: true)
  
//       Main layer for the progressview
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 9
        shapeLayer.strokeColor = UIColor.flatBlue.cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.position = view.center
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        
        btnProgressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(customCircularProgress)))

    }
    
    @objc private func customCircularProgress(){
        
        let basicAnim = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnim.toValue = 1
        basicAnim.duration = 5
        
        // Two lines code for the end of the anim.
        basicAnim.fillMode = kCAFillModeForwards
        basicAnim.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnim, forKey: "SoEasy")
        

    }
    
    //MARK: Start the timer
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
//        perform(#selector(updateTimer), with: nil)
        //if timer hit 0 give an alert !!
    }
    
    @objc func updateTimer(){
        seconds -= 0.01
        lblTimeShow.text = String(format: "%.2f", seconds)
    }
    
    //MARK: Stop the timer
    func stopTimer(){
        if timer.isValid == true{
            timer.invalidate()
        }
    }
    
    func resetTimer(){
        timer.invalidate()
        seconds = 5
        lblTimeShow.text = "\(seconds)"
    }
    
    func loadQuestions(){
         questionArray = realm.objects(Question.self) // pull the all questions in variable
    }
    
    func updateQuestionScreen(button: UIButton){
        button.setTitleColor(UIColor.flatWhite, for: .normal)
        button.setTitle("Kartı Aç", for: .normal)
        questionNumber += 1
    }
    
    func lblWhoWillPlay(playerTurn: Int) {
        lblTurnSpecifier.text = "Sorunun sahibi \(playerArray[playerTurn].name)"
        lblTurnSpecifier.textColor = UIColor.flatBlack
        lblTurnSpecifier.textAlignment = .center
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
