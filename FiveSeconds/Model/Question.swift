//
//  Data.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 11.07.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import Foundation
import RealmSwift


class Question: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var questionNumber: Int = 0
    @objc dynamic var date = Date()
//    var parentRelation = LinkingObjects(fromType: Player.self, property: "questions")
}
