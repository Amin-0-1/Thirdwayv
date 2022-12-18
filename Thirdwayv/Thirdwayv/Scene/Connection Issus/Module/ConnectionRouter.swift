//
//  NoConnectionRouter.swift
//  Movies
//
//  Created by Amin on 16/12/2022.
//

import UIKit


protocol ConnectionRouterProtocol{
    func dismiss()
}

class ConnectionRouter: ConnectionRouterProtocol{
    var viewController: UIViewController!
    
    static func createModule() -> UIViewController {
        
        let view = ConnectionVC()
        let presenter = ConnectionPresenter(router: ConnectionRouter(view: view))
        let router = ConnectionRouter(view: view)

        presenter.router = router
        return view
    }

    func dismiss() {
        viewController.dismiss(animated: true)
    }
    
    init(view: UIViewController) {
        self.viewController = view
    }
    
    
}
