//
//  Connection.swift
//  Movies
//
//  Created by Amin on 16/12/2022.
//

import Foundation
import Network


enum ConnectionStatus{
    case Online
    case Offline
}
protocol ConnectionNotifiable: AnyObject {
    func connection(status:ConnectionStatus)
}
class Connectivity{
    
    static var shared = Connectivity()
    private var path:NWPathMonitor?
    private let queue = DispatchQueue.global()
    private var listener : ConnectionNotifiable?
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
            let isConnected = path.status != .unsatisfied
            
            guard isConnected != self.isConnected else {return}
            self.isConnected = isConnected
            
            DispatchQueue.main.async {
                self.listener?.connection(status: self.isConnected ? .Online : .Offline)
            }
        }
    }
    
    func addListener(listener:ConnectionNotifiable){
        self.listener = nil
        self.listener = listener
    }
}
