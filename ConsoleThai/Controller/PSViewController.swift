//
//  FirstViewController.swift
//  ConsoleThai
//
//  Created by Surote Gaide on 19/5/20.
//  Copyright © 2020 Surote Gaide. All rights reserved.
//

import UIKit

class PSViewController: UIViewController {
    
    @IBOutlet weak var threadTable: UITableView!
    @IBOutlet weak var deviceBar: UITabBarItem!
    
    var dataManager = DataManager()
    var localThread = [Thread]()
    var postIDPressed:Int?
    var threadTitle:String?
    var currentPage = 1

    let threadRefresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataManager.threadDelegate = self
        threadTable.dataSource = self
        dataManager.downloadForumJSON(device: Devices(rawValue: deviceBar.tag)!.device ,page: currentPage)
        threadTable.refreshControl = threadRefresh
        threadTable.backgroundColor = .clear
        view.setGradientBG(colorOne: Colors.darkblue, colorTwo: Colors.blue)
        
        }
    
    @objc func refresh(sender: UIRefreshControl){
        dataManager.downloadForumJSON(device: Devices(rawValue: deviceBar.tag)!.device, page: currentPage)
        sender.endRefreshing()
    }
}

extension PSViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localThread.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "threadCell") as! ThreadCell
        cell.threadName.text = localThread[indexPath.row].title
        cell.threadUsername.text = localThread[indexPath.row].username
        if localThread[indexPath.row].isWatching {
            cell.onlineStatus.image = Status.online.image
        } else {
            cell.onlineStatus.image = Status.offline.image
        }
        let localPrefix = localThread[indexPath.row].prefixID
        if localPrefix == 1 || localPrefix == 7 {
            cell.prefix.image = Prefix.sell.image
        } else if localPrefix == 2 || localPrefix == 8 {
            cell.prefix.image = Prefix.buy.image
        } else {
            cell.prefix.image = Prefix.close.image
        }
        cell.viewNumber.text = String(localThread[indexPath.row].viewCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postIDPressed = localThread[indexPath.row].firstPostID
        threadTitle = localThread[indexPath.row].title
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "BringUpThread", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ThreadViewController {
            //passing data to threadviewcontroller
            destination.postID = postIDPressed
            destination.titleOfThread = threadTitle
        }
    }
}
extension PSViewController: ThreadsManagerDelegate {
    func didGetThreadData(dataManager: DataManager, thread: ThreadData) {
        localThread = thread.threads
        DispatchQueue.main.async {
            self.threadTable.reloadData()
        }
    }
    
    func didFail(error: Error) {
        print(error)
    }
    

}
