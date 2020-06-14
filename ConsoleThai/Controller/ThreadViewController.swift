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
    @IBOutlet weak var contactMe: UILabel!
    @IBOutlet weak var rankingMeter: UIImageView!
    
    //IBOutlets
    var dataManager = DataManager()
    var localPost: PostInfo?
    var postID:Int?
    var titleOfThread:String?
    var dateOfPost:Date?
    var attachments = [Attachments]()
    var imageData:UIImage?
    var imageArray = [UIImage]()
    
    
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
            print("Found \(attachments.count) attachments")
            addImageToArray(ids: attachments)
        }
        DispatchQueue.main.async {
            self.postingDate.text = "โพสต์เมื่อ : \(self.dateOfPost?.asString(style: .medium) ?? "ไม่มีข้อมูล")"
            self.rankingMeter.image = UIImage(named:"r\(post.post.thread?.customfields.conditionField ?? "1").png")
            self.contactMe.text = String(post.post.thread?.customfields.contactField ?? "ไม่มีข้อมูล")
            self.message.text = post.post.message
            self.threadTitle.text = self.titleOfThread
            self.attachmentCV.reloadData()
        }
    }
    
    func didFail(error: Error) {
        print(error)
    }
    
    func addImageToArray(ids:[Attachments]) {
        for image in ids {
            dataManager.downloadAttachment(id: image.attachmentID) { (data) in
                self.imageArray.append(UIImage(data: data)!)
            }
        }
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ShowPhoto", sender: self)
                }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PhotoViewPage {
            destination.photoArray = imageArray
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
