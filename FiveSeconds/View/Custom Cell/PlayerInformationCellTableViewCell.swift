//
//  PlayerInformationCellTableViewCell.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 5.07.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import UIKit

protocol PlayerInformationCellTableViewCellDelegate: class {
    func getTextFieldName(_ sender: PlayerInformationCellTableViewCell)
}


class PlayerInformationCellTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var usrImgView: UIImageView!
    @IBOutlet weak var txtPlayerName: UITextField!

    
    weak var delegate: PlayerInformationCellTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtPlayerName.delegate = self
        usrImgView.image = #imageLiteral(resourceName: "avatar")
        txtPlayerName.backgroundColor = UIColor.flatWhite
        txtPlayerName.layer.cornerRadius = 5
        txtPlayerName.textAlignment = .center
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.getTextFieldName(self)
        
//        playerName = textField.text!
//        print(playerName)
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
