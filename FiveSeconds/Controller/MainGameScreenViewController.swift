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
import AVFoundation


class MainGameScreenViewController: UIViewController {
    
    @IBOutlet weak var lblTurnSpecifier: UILabel!
    
    @IBOutlet weak var lblProgressViewLocation: UIView!
    
    @IBOutlet weak var btnUncoverQuestion: UIButton!

    @IBOutlet weak var btnProgressView: RoundedButton!
    
    let lblFiveSeconds: UILabel = {
        let label = UILabel()
        label.text = "5.00"
        label.textAlignment = .center
        label.textColor = UIColor.flatWhite
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.backgroundColor = UIColor.black.withAlphaComponent(0)
        return label
    }()
    @IBOutlet weak var lblFistPlace: UILabel!
    
    @IBOutlet weak var lblSecondPlace: UILabel!
    
//    @IBOutlet weak var lblThirdPlace: UILabel!
    
    @IBAction func btnUncoverQuestion(_ sender: RoundedButton) {
        if btnState == 0{
            playSound(sender.tag)
            //sadece soru görünür ve buton başlata dönüşür
            btnUncoverQuestion.setTitle(questionArray?[questionNumber].title ?? "Soru yok", for: .normal)
            sender.setTitle("Başlat", for: .normal)
            sender.setTitleColor(UIColor.flatWhite, for: .normal)
            btnState = btnState + 1
            
        } else if btnState == 1 {
            playSound(sender.tag)

//            resumePulsinCircle()
            customCircularProgress()
//            animatePulsingCircle()
            sender.setTitle("Tamam", for: .normal)
            sender.setTitleColor(UIColor.flatWhite, for: .normal)
            btnState = btnState + 1
            shapeLayer.strokeEnd = 0
            
            
        } else if btnState == 2 {
            playSound(sender.tag)

//            stopPulsingCircle()
            stopTimer()
            alertOnDoneOrFinish(sender: sender)
            
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        playSound(sender.tag)
        self.dismiss(animated: true, completion: nil)
        
    }

    //MARK: variables and declarations
    
    var sound: AVAudioPlayer!
    var realm = try! Realm()
    var playerArray: [Player] = [] //container for the player
    var questionArray: Results<Question>?
    var turn: Int = 0 //which player should answer the question
    let totalSeconds = Double(5.00)
    var seconds = Double(5.00)
    var timer = Timer()
    var btnState = 0 //what is the state for the big button
    var isTimerRunning = false
    var questionNumber = 0 //specifies the qustion number
    var screenWidth = CGFloat(UIScreen.main.bounds.width)
    
    //MARK: For the progress view declerations
    let shapeLayer = CAShapeLayer()
    let ghostLayer = CAShapeLayer()
    let pulsingLayer = CAShapeLayer()
    var circularPath = UIBezierPath(arcCenter: .zero, radius: 40.0, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
    
    //pulse animation var
    let anim = CABasicAnimation(keyPath: "transform.scale")

    // burası çalışmıyor
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialization for the first player
        lblWhoWillPlay(playerTurn: turn)
        loadQuestions()
        
        
//      pulsingCircle()
        ghostCircle()
        proggressView()
        setupLabel()
        ranking()
        print("deneme")



    }
    
    func setupLabel(){
        view.addSubview(lblFiveSeconds)
        lblFiveSeconds.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        lblFiveSeconds.center = lblProgressViewLocation.center
    }
    
    func ghostCircle(){

        ghostLayer.path = circularPath.cgPath
        
        ghostLayer.lineWidth = 7
        ghostLayer.strokeColor = UIColor.flatGrayDark().cgColor
        ghostLayer.lineCap = CAShapeLayerLineCap.round
        ghostLayer.fillColor = UIColor.clear.cgColor
        ghostLayer.position = lblProgressViewLocation.center
        lblProgressViewLocation.layer.addSublayer(ghostLayer)
    }
//
//    func pulsingCircle(){
//
//        if screenWidth > 374{
//            circularPath = UIBezierPath(arcCenter: .zero, radius: 80.0, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//        }
//
//        pulsingLayer.path = circularPath.cgPath
//
//        pulsingLayer.strokeColor = UIColor.clear.cgColor
//        pulsingLayer.lineCap = kCALineCapRound
//        pulsingLayer.fillColor = UIColor.flatRed.withAlphaComponent(0.4).cgColor
//        pulsingLayer.position = lblProgressViewLocation.center
//
//        view.layer.addSublayer(pulsingLayer)
//    }
//
//    func animatePulsingCircle(){
//
//        if screenWidth > 374{
//            circularPath = UIBezierPath(arcCenter: .zero, radius: 80.0, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//        }
//
//        anim.toValue = 1.3
//        anim.duration = 0.8
//        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
//        anim.autoreverses = true
//        anim.repeatCount = Float.infinity
//
//        pulsingLayer.add(anim, forKey: "pulsingLayer")
//    }
    
//    func stopPulsingCircle(){
//        pulsingLayer.speed = 0.0
//    }
    
//    func resumePulsinCircle(){
//        let pausedTime = pulsingLayer.timeOffset
//        pulsingLayer.speed = 1.0
//        pulsingLayer.timeOffset = 0.0
//        pulsingLayer.beginTime = 0.0
//        let timeSincePause = pulsingLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
//        pulsingLayer.beginTime = timeSincePause
//
//    }
    
    func proggressView(){
        
//       Main layer for the progressview
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.lineWidth = 9
        shapeLayer.strokeColor = UIColor.flatWhite.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.position = lblProgressViewLocation.center
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
    
    }
    
    func customCircularProgress(){
        
        let basicAnim = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnim.toValue = 1
        basicAnim.duration = 5
        
        // Two lines code for the end of the anim.
        basicAnim.fillMode = CAMediaTimingFillMode.forwards
        basicAnim.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnim, forKey: "SoEasy")
        startTimer()
        
    }
    
    //MARK: Start the timer
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        
    }

    
    @objc func updateTimer(){
        if seconds < 0.01  {
            timer.invalidate()
            alertOnDoneOrFinish(sender: btnProgressView)
//            stopPulsingCircle()
        }else {
            seconds = seconds - 0.01
            lblFiveSeconds.text = String(format: "%.2f", seconds)
        }
    }
    
    //MARK: Stop the timer
    func stopTimer(){
        if timer.isValid == true{
            timer.invalidate()
        }
    }
    
    func resetTimer(){
        timer.invalidate()
        seconds = totalSeconds
        lblFiveSeconds.text = "\(seconds)"
        isTimerRunning = false
    }
    
    func loadQuestions(){
         questionArray = realm.objects(Question.self) // pull the all questions in variable
        print(questionArray?.count ?? 0)

    }
    
    func updateQuestionScreen(button: RoundedButton){
        button.setTitleColor(UIColor.flatWhite, for: .normal)
        button.setTitle("Kartı Aç", for: .normal)
        questionNumber += 1
    }
    
    func lblWhoWillPlay(playerTurn: Int) {
        lblTurnSpecifier.text = "Sorunun sahibi \(playerArray[playerTurn].name)"
        lblTurnSpecifier.textColor = UIColor.flatWhite
        lblTurnSpecifier.textAlignment = .center
        lblTurnSpecifier.font = UIFont.init(name: "KGTenThousandReasons", size: 17.0)
        lblFistPlace.text = "\(playerArray[turn].name)"
        
    }
    
    func alertOnDoneOrFinish(sender: RoundedButton){
        let alert = UIAlertController(title: "Sizce cevap doğru mu", message: "Seçimin yap", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Doğru", style: .default, handler: { (trueAction) in
            self.playerArray[self.turn].point += 1
            if self.playerArray.count == self.turn + 1 {
                self.turn = 0
            }else {
                self.turn += 1
            }

            self.updateQuestionScreen(button: sender)
            self.btnState = 0
            self.resetTimer()
            self.lblWhoWillPlay(playerTurn: self.turn)
            self.btnUncoverQuestion.setTitle("", for: .normal)
            self.playerArray.sort(by: self.sorterForPoint(this:that:))
            self.ranking()
            
        }))
        alert.addAction(UIAlertAction(title: "Yanlış", style: .default, handler: { (wrongAction) in
            
            if self.playerArray.count == self.turn + 1 {
                self.turn = 0
            }else {
                self.turn += 1
            }
            self.updateQuestionScreen(button: sender)
            self.btnState = 0
            self.resetTimer()
            self.lblWhoWillPlay(playerTurn: self.turn)
            self.btnUncoverQuestion.setTitle("", for: .normal)
            self.ranking()
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func sorterForPoint(this: Player, that: Player) -> Bool {
        return this.point > that.point
    }
    
    func ranking(){
        var sortedArray: [Player] = []
        
        for item in playerArray {
            sortedArray.append(item)
        }
        
        sortedArray.sort { $0.point > $1.point }
        lblFistPlace.text = sortedArray[0].name
        lblSecondPlace.text = sortedArray[1].name
        
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
    
    func playerMakeFatality(players: [Player]){
        //func that finishing the game
    }

//END OF THE CLASS DECLARATION
}
