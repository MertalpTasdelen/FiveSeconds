//
//  GameScreenViewController.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 22.06.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import RealmSwift


class GameScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, PlayerInformationCellTableViewCellDelegate {

    
    @IBOutlet weak var lblForOrientation: UILabel!
    
    @IBOutlet weak var tblPlayerNames: UITableView!
    
    @IBAction func btnStart(_ sender: RoundedButton) {
        performSegue(withIdentifier: "mainGameScreen", sender: self)
    }
    
    @IBAction func btnBack(_ sender: RoundedButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var playerCount : Int = 0
    var playerNumber = 0
    var tempPlayers: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblPlayerNames.delegate = self
        tblPlayerNames.dataSource = self
        
        tblPlayerNames.register(UINib(nibName: "PlayerInformationCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cellForPlayer")
        configureTableView()
        
        let tappingForClosingKeyboard = UITapGestureRecognizer(target: self, action: #selector(buttonPressed))
        view.addGestureRecognizer(tappingForClosingKeyboard)
        
        print("Number of player \(playerCount)")
    }
    
    @objc func buttonPressed(){
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(playerCount)
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForPlayer", for: indexPath) as! PlayerInformationCellTableViewCell
        
        cell.txtPlayerName.text = "Oyuncu \(playerNumber + 1)"
        playerNumber = playerNumber + 1
        cell.delegate = self

        return cell
    }
    
    func getTextFieldName(_ sender: PlayerInformationCellTableViewCell) {
//        guard let enteredName = tblPlayerNames.indexPath(for: sender) else {return}
//
//        print(sender.txtPlayerName.text!)
        var playerUnknown = Player(name: sender.txtPlayerName.text!, point: 0) 
        tempPlayers.append(playerUnknown)
        
    }
    
    
    func configureTableView(){
        tblPlayerNames.rowHeight = UITableViewAutomaticDimension
        tblPlayerNames.estimatedRowHeight = 50.0
    }
  
    
    //This func. for the person who will play the game next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainGameScreen"{
            let nextVC = segue.destination as! MainGameScreenViewController
            for item in tempPlayers{
                nextVC.playerArray.append(item)
            }
            //After this declaration we can use the MainGameScreenViewController variables in this screen!!!!

        }
    }
    
    
}
