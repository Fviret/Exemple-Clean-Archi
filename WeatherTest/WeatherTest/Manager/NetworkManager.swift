//
//  NetworkManager.swift
//

import Foundation
import Network


class NetworkManager {
    
    static var manager = NetworkManager()
    static let NetworkStatusDidChange = Notification.Name("NetworkStatusDidChange")
    var monitor = NWPathMonitor()
    
    var hasNetworkAccess: Bool {
        return monitor.currentPath.status == .satisfied
    }
    
    init() {
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func setup() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Self.NetworkStatusDidChange, object: nil)
            }
        }
    }
}
