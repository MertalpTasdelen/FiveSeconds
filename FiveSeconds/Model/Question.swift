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
    @objc dynamic var date = Date()
}
