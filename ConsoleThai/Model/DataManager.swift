//
//  DataManager.swift
//  ConsoleThai
//
//  Created by Surote Gaide on 19/5/20.
//  Copyright © 2020 Surote Gaide. All rights reserved.
//

import Foundation

protocol DataManagerDelegate {
    func didGetThreadData(dataManager: DataManager, thread: ThreadData)
    func didFail(error: Error)
}

class DataManager {
    
    var delegate:DataManagerDelegate?
    
        let url = "https://www.consolethai.com/api/forums/"
        
        func downloadThreadJSON(device:String){
            let finalUrl = "\(url)\(device)"
            if let url = URL(string: finalUrl){
                var request = URLRequest(url: url)
                request.setValue("D06DPe9piI0syIxUMnleZijaKrphWPNx",
                                 forHTTPHeaderField: "XF-Api-Key")
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: request) { (data, response, error) in
                    if error != nil {
                        self.delegate?.didFail(error: error!)
                        return
                    }
                    print("Thread Downloaded")
                    do  {
                        let decoder = JSONDecoder()
                        let decodedThread = try decoder.decode(ThreadData.self, from: data!)
                        self.delegate?.didGetThreadData(dataManager: self, thread: decodedThread)
                    } catch {
                        self.delegate?.didFail(error: error)
                    }
                }
                task.resume()
        }
    }
        
}

