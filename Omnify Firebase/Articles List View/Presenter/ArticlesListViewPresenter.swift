//
//  ArticlesListViewPresenter.swift
//  Omnify Firebase
//
//  Created by Ashok Kumar S on 10/10/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

import UIKit

protocol ArticlesPresenterDelegate {
    
}

class ArticlesListViewPresenter {

    var articlesDatasource: [Article]? = nil
    var delegate: ArticlesPresenterDelegate? = nil
    
    init(delegate: ArticlesPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getTopStories(completion: @escaping ([Article]?, Error?) -> Void) {
        
        NetworkManager.getTopStories { (articles, error) in
            self.articlesDatasource = articles
            completion(articles, error)
        }
    }
    
    func getUpdatedInformation(for article: Article) -> String {
        
        if article.time > -1 {
            return "\(getDateCreated(fromDate: article.time)) * \(article.by ?? " ")"
        }
        return article.by ?? " "
    }
    
    func getDateCreated(fromDate date: Int) -> String {
        
        let timeDifference = Int((Int(Date().timeIntervalSince1970) - date) / 60) // 60000 is to convert milliseconds to minutes
        
        if timeDifference < 60 {
            return timeDifference <= 1 ? "\(timeDifference) minute ago" : "\(timeDifference) minutes ago"
            
        } else if (timeDifference >= 60 && timeDifference < (60 * 24)) {
            
            let time = Int(timeDifference/60)
            
            return time > 1 ? "\(time) hours ago" : "\(time) hour ago"
            
        } else if (timeDifference >= (60 * 24) && timeDifference < (60 * 24 * 7)) {
            
            let time = Int(timeDifference/(60 * 24))
            
            return time > 1 ? "\(time) days ago" : "\(time) day ago"
            
        } else {
            return getTimeLabel(timeResult: date)
        }
    }
    
    func getTimeLabel(timeResult: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timeResult/1000))
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        return dateFormatterPrint.string(from: date).capitalized
    }
}
