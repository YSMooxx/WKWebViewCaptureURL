//
//  NetStatusManager.swift
//  UniversalRremote
//
//  Created by Hao Liu on 2024/8/8.
//

import Network

enum NetStatus{
    
    case NoNet
    case WIFI
    case WWAN
}


class NetStatusManager: NSObject {
    static let manager:NetStatusManager = NetStatusManager()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    var currentStatus:NetStatus?
    
    func startNet(netStatus: @escaping(NetStatus)->Void) {
        
        monitor.pathUpdateHandler = { path in
            
            if path.status == .satisfied {
                
                if path.isExpensive {
                    
                    if self.currentStatus != .WWAN {
                        
                        self.currentStatus = .WWAN
                        netStatus(.WWAN)
                    }
                    
                    
                } else {
                    
                    
                    
                    if self.currentStatus != .WIFI {
                        
                        self.currentStatus = .WIFI
                        netStatus(.WIFI)
                    }
                    
                }
            } else {
                
                
                if self.currentStatus != .NoNet {
                    
                    self.currentStatus = .NoNet
                    netStatus(.NoNet)
                }
                
            }
        }
                
        monitor.start(queue: queue)
    }
    
    func stop() {
        
        monitor.cancel()
    }
    
}
