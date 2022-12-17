//
//  Presenter.swift
//  Movies
//
//  Created by Amin on 16/12/2022.
//

import Foundation

class ConnectionPresenter: ConnectionPresenterProtocol{
    var router: ConnectionRouterProtocol!
    var view: ConnectionViewToPresenter!
    
}

extension ConnectionPresenter: ConnectionPresenterToView{
    func onScreenAppeared() {
//        let con = Connectivity.shared
//        con.getConnectionPath().pathUpdateHandler = { [unowned self] path in
//            if path.status == .satisfied{
//                router.dismiss()
//            }
//        }
    }
}
