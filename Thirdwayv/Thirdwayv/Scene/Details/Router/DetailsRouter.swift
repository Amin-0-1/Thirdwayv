//
//  DetailsRouter.swift
//  Thirdwayv
//
//  Created by Amin on 17/12/2022.
//

import UIKit

class DetailsRouter{
    
    var vc:UIViewController
    
    init(vc:UIViewController){
        self.vc = vc
    }
    
    static func createModule(withModel product: ProductModel)->UIViewController{
        let vc = DetailsVC()
        let presenter = DetailsPresenter(product: product)
        vc.presenter = presenter
        
        return vc
        
    }
}
