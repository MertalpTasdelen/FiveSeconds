//
//  Player.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 6.07.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Player: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var point: Int = 0
//    let askedQuestions = List<Question>()
}
