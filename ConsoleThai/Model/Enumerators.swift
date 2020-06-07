//
//  PrefixStatus.swift
//  ConsoleThai
//
//  Created by Surote Gaide on 5/6/20.
//  Copyright © 2020 Surote Gaide. All rights reserved.
//

import Foundation
import UIKit

enum Status{
    case online
    case offline
    
    var image: UIImage {
        switch self {
        case .online:
            return UIImage(named: "online.jpg")!
        case .offline:
            return UIImage(named: "offline.jpg")!
        }
    }
}
enum Prefix {
    case sell
    case buy
    case close
    
    var image: UIImage {
        switch self {
        case .sell:
            return UIImage(named: "sell.jpg")!
        case .buy:
            return UIImage(named: "buy.jpg")!
        case .close:
            return UIImage(named: "close.jpg")!
        }
    }
}
enum Devices:Int {
    case ps4 = 1
    case ns = 2
    case xb = 3
    
    var device: String {
        switch self{
        case .ps4:
            return "5/threads"
        case .ns:
            return "37/threads"
        case .xb:
            return "32/threads"
        }
    }
}
