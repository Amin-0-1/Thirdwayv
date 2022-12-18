//
//  Protocols.swift
//  Movies
//
//  Created by Amin on 16/12/2022.
//

import UIKit

//MARK: view protocols
protocol ConnectionVCProtocol{
    var presenter: ConnectionPresenterToView! {get set}
}

protocol ConnectionViewToPresenter{
    
}

//MARK: presenter protocols
protocol ConnectionPresenterProtocol{
    var router: ConnectionRouterProtocol! {get set}
    var view: ConnectionViewToPresenter! {get set}
}
protocol ConnectionPresenterToView{
    func onScreenAppeared()
}

//MARK: router protocols

protocol ConnectionRouterProtocol{
    static func createModule()->UIViewController
    var viewController: UIViewController! { get set }
    func dismiss()
    init(view:UIViewController)
}
