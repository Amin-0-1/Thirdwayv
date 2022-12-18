//
//  Connection.swift
//  Movies
//
//  Created by Amin on 16/12/2022.
//

import Foundation
import Network

class Connectivity{
    
    static var shared = Connectivity()
    private var path:NWPathMonitor?
    private let queue = DispatchQueue.global()
    public private(set) var isConnected:Bool = false
    private init(){
        path = NWPathMonitor()
    }
    
    func startMonitoring(){
        guard let path = path else {
            return
        }
        path.start(queue: self.queue)
        path.pathUpdateHandler = {[weak self] path in
            guard let self = self else {return}
            self.isConnected = path.status != .unsatisfied
            print(self.isConnected)
        }
    }
    func getConnectionPath()->NWPathMonitor?{
        return path
    }
}
