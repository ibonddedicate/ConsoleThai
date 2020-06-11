//
//  PhotoViewPage.swift
//  ConsoleThai
//
//  Created by Surote Gaide on 11/6/20.
//  Copyright © 2020 Surote Gaide. All rights reserved.
//

import UIKit

class PhotoViewPage: UIViewController {

    @IBOutlet weak var fullSizePhoto: UIImageView!
    var photo:UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        fullSizePhoto.image = photo
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissPhoto(_ sender: Any) {
        self.dismiss(animated: true) {
            print("Photo Dismissed")
        }
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
