//
//  NetworkManager.swift
//  Omnify Firebase
//
//  Created by Ashok Kumar S on 10/10/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static func getTopStories() {
        
        guard let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let destinationFileUrl = documentsUrl.appendingPathComponent("topstories.json")
        
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json")

        let request = URLSession.shared.downloadTask(with: url!) { (storedPath, response, error) in
            
            do {
                try FileManager.default.copyItem(at: storedPath!, to: destinationFileUrl)
            } catch (let writeError) {
                print("Error creating a file \(destinationFileUrl) : \(writeError)")
            }
            
            print(response ?? "nil response")
        }

        request.resume()
    }
}
