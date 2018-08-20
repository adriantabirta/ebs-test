//
//  ReachabilityManager.swift
//  EbsTest
//
//  Created by Oneest on 8/18/18.
//  Copyright © 2018 Oneest. All rights reserved.
//

import UIKit

final class ReachabilityManager: NSObject {
    
    let reachability = ReachabilitySwift()
    
    var isNetworkAvailable: Bool {
        guard let rich = reachability?.isReachable else {
            return true 
        }
        
        return rich
//        return return (reachability?.isReachable)
    }
    
    override init() {
        super.init()
        reachability?.whenReachable = { reachability in
            DispatchQueue.main.async {
                if reachability.isReachableViaWiFi {
                    print("Reachable via WiFi")
//                    Model.UI.hideReachabilityView()
                } else {
                    print("Reachable via Cellular")
//                    Model.UI.hideReachabilityView()
                }
            }
        }
        
        reachability?.whenUnreachable = { reachability in
            Alert().message("Looks like you are offline !").show()
        }
    }
    
    func startMonitoring() {
        do{
            try reachability?.startNotifier()
        }catch{
            debugPrint("could not start reachability notifier")
        }
    }
    
    func stopMonitoring(){
        reachability?.stopNotifier()
    }
}

