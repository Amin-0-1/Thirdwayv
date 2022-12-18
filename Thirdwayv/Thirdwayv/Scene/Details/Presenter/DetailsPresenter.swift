//
//  DetailsPresenter.swift
//  Thirdwayv
//
//  Created by Amin on 17/12/2022.
//

import Foundation

protocol DetailsPresenterToView{
    func getImageData()->Data?
    func getPrice()->Int
    func getDesc()->String
}

class DetailsPresenter:DetailsPresenterToView{
 
    private var product:ProductModel!
    init(product:ProductModel){
        self.product = product
    }
    
    func getImageData() -> Data? {
        return product.image?.imageData
    }
    
    func getPrice() -> Int {
        return product.price ?? Int.random(in: 100...1000)
    }
    
    func getDesc() -> String {
        return product.productDescription ?? UUID().description
    }
    
}
