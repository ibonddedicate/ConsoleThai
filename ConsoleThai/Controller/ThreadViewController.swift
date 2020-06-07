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
    var titleOfThread:String?
    var attachments = [Attachments]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataManager.postDelegate = self
        dataManager.downloadPostJSON(number: postID!)
        attachmentCV.delegate = self
        attachmentCV.dataSource = self
    }
    
    func didGetPostData(dataManager: DataManager, post: PostData) {
        if post.post.attachments != nil {
            attachments = post.post.attachments!
            print(attachments.count)
        }
        DispatchQueue.main.async {
            self.message.text = post.post.message
            self.threadTitle.text = self.titleOfThread
            self.attachmentCV.reloadData()
        }
    }
    
    func didFail(error: Error) {
        print(error)
    }

}

extension ThreadViewController : UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if attachments.count  == 0 {
            return 1
        } else {
            return attachments.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttachmentCell", for: indexPath) as! AttachmentCell
        if attachments.count > 0 {
            let thumbURL = URL(string: attachments[indexPath.row].thumbnailUrl)!
            cell.attachmentImage.load(url: thumbURL)
        }
        return cell
    }

}

extension UIImageView {
    func load(url:URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
