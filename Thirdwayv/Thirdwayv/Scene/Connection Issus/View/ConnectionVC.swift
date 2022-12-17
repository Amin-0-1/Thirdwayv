//
//  ConnectionVC.swift
//  Movies
//
//  Created by Amin on 16/12/2022.
//

import UIKit

class ConnectionVC: UIViewController , ConnectionVCProtocol{
    var presenter: ConnectionPresenterToView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.onScreenAppeared()
    }

}

extension ConnectionVC: ConnectionViewToPresenter{
    
}
