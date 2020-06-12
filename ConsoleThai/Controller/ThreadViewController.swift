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
    @IBOutlet weak var postingDate: UILabel!
    
    //IBOutlets
    var dataManager = DataManager()
    var localPost: PostInfo?
    var postID:Int?
    var titleOfThread:String?
    var dateOfPost:Date?
    var attachments = [Attachments]()
    var imageData:UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataManager.postDelegate = self
        dataManager.downloadPostJSON(number: postID!)
        attachmentCV.delegate = self
        attachmentCV.dataSource = self
        
    }
    
    func didGetPostData(dataManager: DataManager, post: PostData) {
        dateOfPost = Date.init(timeIntervalSince1970: TimeInterval(post.post.postDate))
        if post.post.attachments != nil {
            attachments = post.post.attachments!
            print("Found \(attachments.count) attachements")
        }
        DispatchQueue.main.async {
            self.postingDate.text = "โพสต์เมื่อ : \(self.dateOfPost?.asString(style: .medium) ?? "ไม่มีข้อมูล")"
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
            attachmentCV.isHidden = true
            return 0
        } else {
            attachmentCV.isHidden = false
            return attachments.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttachmentCell", for: indexPath) as! AttachmentCell
        if attachments.count > 0 {
            let thumbURL = URL(string: attachments[indexPath.row].thumbnailUrl)!
            cell.attachmentImage.load(url: thumbURL)
        }
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let attachmentID = attachments[indexPath.row].attachmentID
            dataManager.downloadAttachment(id: attachmentID) { (data) in
                self.imageData = UIImage(data: data)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ShowPhoto", sender: self)
                }
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PhotoViewPage {
            destination.photo = self.imageData
        }
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

extension Date {
  func asString(style: DateFormatter.Style) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = style
    return dateFormatter.string(from: self)
  }
}
