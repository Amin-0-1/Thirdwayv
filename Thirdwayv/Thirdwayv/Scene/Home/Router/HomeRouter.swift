//
//  HomeRouter.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import UIKit

protocol HomeRouterToPresenter{
    func navigateToPopupError(message:String,completion:(()->Void)?)
    func navigateToPopupInfo(message:String,completion:(()->Void)?)
    func navigateToDetails(withProduct:ProductModel)
    func navigateToConnectionIssue()
    func navigateToOnlineToast()
    func navigateToOfflineToast()
}
class HomeRouter:HomeRouterToPresenter{
    
    var vc: UIViewController!
    
    init(vc:UIViewController){
        self.vc = vc
    }
    
    static func createModule()->UINavigationController{
        let vc = HomeVC()
        let presenter = HomePresenter()
      
        let interactor = HomeInteractor()
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
        
        let transition: CATransition = .init()
        transition.duration = 0.3
        transition.type = .reveal
        transition.subtype = .fromRight
        self.vc.view.window?.layer.add(transition, forKey: nil)
        
        self.vc.navigationController?.pushViewController(vc, animated: false)
    }
    func navigateToPopupError(message:String,completion:(()->Void)? = nil) {
        let vc = PopupMessage()
        vc.isModalInPresentation = true
        vc.modalTransitionStyle = .crossDissolve
        vc.configure(state: .Error, message: message,completion: completion)
        self.vc.present(vc, animated: true)
    }
    
    func navigateToPopupInfo(message:String,completion:(()->Void)? = nil) {
        let vc = PopupMessage()
        vc.isModalInPresentation = true
        vc.modalTransitionStyle = .crossDissolve
        vc.configure(state: .Info, message: message,completion: completion)
        self.vc.present(vc, animated: true)
        
    }
    
    func navigateToConnectionIssue() {
        let vc = ConnectionRouter.createModule()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.vc.present(vc, animated: true)
    }
    func navigateToOnlineToast() {
        let vc = ToastPopup()
        vc.configure("Your are connected", .Success)
        vc.modalTransitionStyle = .crossDissolve
        self.vc.present(vc, animated: true)
    }
    
    func navigateToOfflineToast() {
        let vc = ToastPopup()
        vc.configure("Your are disconnected", .Error)
        vc.modalTransitionStyle = .crossDissolve
        self.vc.present(vc, animated: true)
    }
    
}
