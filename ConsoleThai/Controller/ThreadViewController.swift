//
//  ThreadViewController.swift
//  ConsoleThai
//
//  Created by Surote Gaide on 7/6/20.
//  Copyright © 2020 Surote Gaide. All rights reserved.
//

import UIKit

class ThreadViewController: UIViewController, PostManagerDelegate {
    
    @IBOutlet weak var message: UILabel!
    //IBOutlets
    var dataManager = DataManager()
    var localPost: PostInfo?
    var postID:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataManager.postDelegate = self
        dataManager.downloadPostJSON(number: postID!)
    }
    
    func didGetPostData(dataManager: DataManager, post: PostData) {
        DispatchQueue.main.async {
            self.message.text = post.post.message
        }
    }
    
    func didFail(error: Error) {
        print(error)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
