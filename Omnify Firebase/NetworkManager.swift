//
//  NetworkManager.swift
//  Omnify Firebase
//
//  Created by Ashok Kumar S on 10/10/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static func getTopStories(completion: @escaping ([Article]?, Error?) -> Void) {
        
        getTopStoryIds { (fileUrl, error) in
            
            if let error_ = error {
                //TODO: Hanlde the error in UI
                debugPrint(error_.localizedDescription)
                
            } else if let fileUrl_ = fileUrl {
                
                do {
                    let data = try Data(contentsOf: fileUrl_, options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonResult = jsonResult as? [Int] {
                        debugPrint(jsonResult)
                        self.getTapStories(byIds: Array(jsonResult.prefix(20)), completion: { (articles, error) in
                            completion(articles, error)
                        })
                    }
                } catch {
                    //TODO: Hanlde the error in UI
                }
                
            } else {
                //TODO: Hanlde the error in UI
            }
        }
    }
    
    static func getTopStoryIds(completion: @escaping (URL?, Error?) -> Void) {
        
        guard let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(nil, nil)
            return
        }
        
        let destinationFileUrl = documentsUrl.appendingPathComponent("topstories.txt")
        
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json")
        
        let request = URLSession.shared.downloadTask(with: url!) { (storedPath, response, error) in
            
            do {
                guard let path = storedPath else {
                    //TODO: Hanlde the error in UI
                    debugPrint("Error creating a file at \(destinationFileUrl)")
                    return
                }
                
                try? FileManager.default.removeItem(at: destinationFileUrl)
                try FileManager.default.moveItem(at: path, to: destinationFileUrl)
                debugPrint(destinationFileUrl.absoluteString)
                
                completion(destinationFileUrl, nil)
                
            } catch (let writeError) {
                //TODO: Hanlde the error in UI
                completion(nil, writeError)
                debugPrint("Error creating a file \(destinationFileUrl) : \(writeError)")
            }
        }
        
        request.resume()
    }
    
    static func getTapStories(byIds ids:[Int], completion: @escaping ([Article]?, Error?) -> Void) {
        
        var articles = [Article]()
        var storedError: Error?
        
        DispatchQueue.global(qos: .userInitiated).async {
            let dispatchGroup = DispatchGroup()
            
            for id in ids {
                //if let id = ids.first {
                
                let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")
                
                dispatchGroup.enter()
                
                let request = URLSession.shared.downloadTask(with: url!) { (storedPath, response, error) in
                    
                    dispatchGroup.leave()
                    
                    if let fileUrl_ = storedPath {
                        
                        do {
                            let data = try Data(contentsOf: fileUrl_, options: .mappedIfSafe)
                            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                            
                            if let jsonResult_ = jsonResult as? [String: Any], let article_ = Article.getArticle(from: jsonResult_) {
                                articles.append(article_)
                            }
                        } catch (let writeError) {
                            //TODO: Hanlde the error in UI
                            storedError = writeError
                            completion(nil, writeError)
                            debugPrint("Error creating a file \(writeError)")
                        }
                    }                    
                }
                
                request.resume()
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                completion(articles, storedError)
            }
        }
    }
}


















