//
//  HomeRouter.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import UIKit

protocol HomeRouterToPresenter{
    func navigateToConnection()
}
class HomeRouter:HomeRouterToPresenter{
    var vc: UIViewController!
    
    init(vc:UIViewController){
        self.vc = vc
    }
    
    static func createModule()->UINavigationController{
        let vc = HomeVC()
        let presenter = HomePresenter()
        let datasource: Datasourceable = Connectivity.shared.isConnected ? DatasourceFactory.buildDataSource(type: .Online) : DatasourceFactory.buildDataSource(type: .Offline)
        
        let interactor = HomeInteractor(datasource: datasource)
        presenter.interactor = interactor
        presenter.router = HomeRouter(vc: vc)
        presenter.view = vc
        interactor.presenter = presenter
        vc.presenter = presenter
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
    
    func navigateToConnection() {
        
    }
    
}
