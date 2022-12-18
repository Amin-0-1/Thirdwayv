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
    func stopPaginating()
    func didSelectItem(at index: Int)
}



protocol HomePresenterToInteractor:AnyObject{
    func onFinishFetching(withData:[ProductModel])
    func onFinishFetching(withError error:CustomError)
    func onFinishCaching(withError error:CustomError)
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
        guard let image = products[index].image else {return 50}
        return image.height ?? 50
    }
    
    func isPaginating() -> Bool {
        return pagination
    }
    
    func stopPaginating() {
        pagination = false
    }
    func didSelectItem(at index: Int) {
        let product = products[index]
        router.navigateToDetails(withProduct: product)
    }
    
}


extension HomePresenter: HomePresenterToInteractor{
    
    func onFinishFetching(withData data: [ProductModel]) {
        view.hideLoading()
        products += data
        view.onFinishFetching()
//        pagination = true
    }
    
    func onFinishFetching(withError error: CustomError) {
        router.navigateToPopupError(message: error.description)
    }
    
    func onFinishCaching(withError error: CustomError) {
        router.navigateToPopupError(message: error.description)
    }
}
