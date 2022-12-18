//
//  Presenter.swift
//  Movies
//
//  Created by Amin on 16/12/2022.
//

import Foundation

class ConnectionPresenter{
    var router: ConnectionRouterProtocol!
    
    init(router: ConnectionRouterProtocol) {
        Connectivity.shared.addListener(listener: self)
        self.router = router
    }
    
}

extension ConnectionPresenter:ConnectionNotifiable{
    func connection(status: ConnectionStatus) {
        switch status {
            case .Online:
                router.dismiss()
            case .Offline:
                break
        }
    }
}
