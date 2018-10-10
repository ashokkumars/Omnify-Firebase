//
//  ArticleModel.swift
//  Omnify Firebase
//
//  Created by Ashok Kumar S on 10/10/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

import Foundation
import RealmSwift

class Article: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var by: String?
    @objc dynamic var descendents: Int = 0
    @objc dynamic var kids = [Int]()
    @objc dynamic var score: Int = 0
    @objc dynamic var time: Int = -1
    @objc dynamic var title: String?
    @objc dynamic var type: String?
    @objc dynamic var url: String?
}
