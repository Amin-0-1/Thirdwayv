//
//  HomeRouter.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import UIKit

protocol HomeRouterToPresenter{
    func navigateToPopupError(message:String)
    func navigateToDetails(withProduct:ProductModel)
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
    
    func navigateToDetails(withProduct product: ProductModel) {
        let vc = DetailsRouter.createModule(withModel: product)
        self.vc.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToPopupError(message:String) {
        let vc = PopupMessage()
        vc.isModalInPresentation = true
        vc.modalTransitionStyle = .crossDissolve
        vc.configure(state: .Info, message: message)
        self.vc.present(vc, animated: true)
    }
    
}
