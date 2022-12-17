//
//  NoConnectionRouter.swift
//  Movies
//
//  Created by Amin on 16/12/2022.
//

import UIKit

class ConnectionRouter: ConnectionRouterProtocol{
    var viewController: UIViewController!
    
    static func createModule() -> UIViewController {
        
        let view = ConnectionVC()
        let presenter = ConnectionPresenter()
        let router = ConnectionRouter(view: view)
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        return view
    }

    func dismiss() {
        viewController.dismiss(animated: true)
    }
    
    required init(view: UIViewController) {
        self.viewController = view
    }
    
    
}
