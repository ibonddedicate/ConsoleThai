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
    @IBOutlet weak var threadTitle: UILabel!
    @IBOutlet weak var attachmentCV: UICollectionView!
    //IBOutlets
    var dataManager = DataManager()
    var localPost: PostInfo?
    var postID:Int?
    var TitleOfThread:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataManager.postDelegate = self
        dataManager.downloadPostJSON(number: postID!)
    }
    
    func didGetPostData(dataManager: DataManager, post: PostData) {
        DispatchQueue.main.async {
            self.message.text = post.post.message
            self.threadTitle.text = self.TitleOfThread
        }
    }
    
    func didFail(error: Error) {
        print(error)
    }

}

extension ThreadViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
