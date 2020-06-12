//
//  PhotoViewPage.swift
//  ConsoleThai
//
//  Created by Surote Gaide on 11/6/20.
//  Copyright © 2020 Surote Gaide. All rights reserved.
//

import UIKit

class PhotoViewPage: UIViewController {

    
    @IBOutlet weak var photoCV: UICollectionView!
    
    var photo:UIImage!
    var photoArray = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        photoCV.delegate = self
        photoCV.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissPhoto(_ sender: Any) {
        self.dismiss(animated: true) {
            print("Photo Dismissed")
        }
    }
}

extension PhotoViewPage: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.photoImage.image = photoArray[indexPath.row]
        return cell
    }
    
}

extension PhotoViewPage: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
