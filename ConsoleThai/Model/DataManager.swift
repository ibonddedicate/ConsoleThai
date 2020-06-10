//
//  DataManager.swift
//  ConsoleThai
//
//  Created by Surote Gaide on 19/5/20.
//  Copyright © 2020 Surote Gaide. All rights reserved.
//

import Foundation

protocol ThreadsManagerDelegate {
    func didGetThreadData(dataManager: DataManager, thread: ThreadData)
    func didFail(error: Error)
}

protocol PostManagerDelegate {
    func didGetPostData(dataManager: DataManager, post: PostData)
    func didFail(error: Error)
}


class DataManager {
    
    var threadDelegate: ThreadsManagerDelegate?
    var postDelegate: PostManagerDelegate?
    let apiKey = "D06DPe9piI0syIxUMnleZijaKrphWPNx"
    
    let urlForum = "https://www.consolethai.com/api/forums/"
    let urlThread =  "https://www.consolethai.com/api/posts/"
    
    
        func downloadForumJSON(device:String,page: Int){
            let finalUrl = "\(urlForum)\(device)?page=\(page)"
            if let url = URL(string: finalUrl){
                var request = URLRequest(url: url)
                request.setValue(apiKey,forHTTPHeaderField: "XF-Api-Key")
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: request) { (data, response, error) in
                    if error != nil {
                        self.threadDelegate?.didFail(error: error!)
                        return
                    }
                    print("Threads List Downloaded")
                    do  {
                        let decoder = JSONDecoder()
                        let decodedThread = try decoder.decode(ThreadData.self, from: data!)
                        self.threadDelegate?.didGetThreadData(dataManager: self, thread: decodedThread)
                    } catch {
                        self.threadDelegate?.didFail(error: error)
                    }
                }
                task.resume()
        }
    }
    
    func downloadPostJSON(number:Int){
        let finalUrl = "\(urlThread)\(number)"
        if let url = URL(string: finalUrl){
            var request = URLRequest(url: url)
            request.setValue(apiKey,forHTTPHeaderField: "XF-Api-Key")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    self.postDelegate?.didFail(error: error!)
                    return
                }
                print("Post Info Downloaded")
                do {
                    let decoder = JSONDecoder()
                    let decodedPost = try decoder.decode(PostData.self, from: data!)
                    self.postDelegate?.didGetPostData(dataManager: self, post: decodedPost)
                } catch {
                    self.postDelegate?.didFail(error: error)
                }
            }
            task.resume()
        }
    }
}

