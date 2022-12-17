//
//  HomePresenter.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import Foundation

protocol HomePresenterToView{
    func fetchProducts()
    func getCount()->Int
    func getModel(forIndexPath: Int)->ProductModel
    func getImageHeight(forIndex index:Int)->Int
    func isPaginating()->Bool
}



protocol HomePresenterToInteractor:AnyObject{
    func onFinishFetching(withData:[ProductModel])
}

class HomePresenter:HomePresenterToView{

  
    weak var view:HomeViewToPresenter!
    var interactor: HomeInteractorToPresenter!
    var router: HomeRouterToPresenter!
    private var pagination = false
    private var products:[ProductModel] = []
    func fetchProducts() {
        guard !pagination else {
            return
        }
        pagination = true
        
        view.showLoading()
        interactor.fetchProducts()
    }
    func getCount() -> Int {
        return products.count
    }
    func getModel(forIndexPath index: Int)-> ProductModel{
        return products[index]
    }
    func getImageHeight(forIndex index:Int)->Int{
        return products[index].image.height
    }
    
    func isPaginating() -> Bool {
        return pagination
    }
    
    
}


extension HomePresenter: HomePresenterToInteractor{
    func onFinishFetching(withData data: [ProductModel]) {
        view.hideLoading()
        products += data
        view.onFinishFetching()
        self.pagination = false
    }
}
