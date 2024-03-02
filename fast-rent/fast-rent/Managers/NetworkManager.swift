//
//  NetworkManager.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/3/2.
//

import Foundation
import Network
import SwiftUI
 
/// A class to monitor Internet connectivity

// src: https://morioh.com/a/68816b37881c/check-network-connection-using-swiftui
final class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
     
    @Published var isConnected = true
    init() {
        monitor.pathUpdateHandler =  { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
    
    func setConnectedViewState(dismissed: inout Binding<Bool>) {
        if (isConnected) {
            dismissed = .constant(false)
        }
    }
}
