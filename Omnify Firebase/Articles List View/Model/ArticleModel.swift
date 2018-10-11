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
    @objc dynamic var descendants: Int = -1
    var kids = List<Int>()
    @objc dynamic var score: Int = -1
    @objc dynamic var time: Int = -1
    @objc dynamic var title: String?
    @objc dynamic var type: String?
    @objc dynamic var url: String?
    
    static func getArticle(from response: [String: Any]) -> Article? {
        
        let article = Article()
        
        let responseKeys = ResponseMappingKeys.TopStoriesKeys()
        
        article.by = response[responseKeys.by] as? String
        article.descendants = response[responseKeys.descendants] as? Int ?? 0
        article.id = response[responseKeys.id] as? Int ?? -1
        article.score = response[responseKeys.score] as? Int ?? 0
        article.kids = response[responseKeys.kids] as? List<Int> ?? List<Int>()
        article.time = response[responseKeys.time] as? Int ?? -1
        article.title = response[responseKeys.title] as? String
        article.type = response[responseKeys.type] as? String
        article.url = response[responseKeys.url] as? String
        
        return article
    }
}


