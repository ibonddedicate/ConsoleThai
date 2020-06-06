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
    
    var dataManager = DataManager()
    var localThread = [Thread]()

    let threadRefresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataManager.delegate = self
        threadTable.dataSource = self
        dataManager.downloadThreadJSON(device: "4/threads")
        threadTable.refreshControl = threadRefresh
        threadTable.backgroundColor = .clear
        
        view.setGradientBG(colorOne: Colors.darkblue, colorTwo: Colors.blue)
        
        }
    @objc func refresh(sender: UIRefreshControl){
        dataManager.downloadThreadJSON(device: "4/threads")
        sender.endRefreshing()
    }
}

extension PSViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localThread.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "threadCell") as! ThreadCell
        //cell?. = localThread[indexPath.row].title
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

}
extension PSViewController: DataManagerDelegate {
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
