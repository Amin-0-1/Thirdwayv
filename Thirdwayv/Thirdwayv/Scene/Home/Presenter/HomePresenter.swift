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
    func onViewWillAppear()
}



protocol HomePresenterToInteractor:AnyObject{
    func onFinishFetching(withData:[ProductModel])
    func onFinishFetching(withError error:CustomError)
    func onFinishCaching(withError error:CustomError)
}

class HomePresenter{
    
    weak var view:HomeViewToPresenter!
    var interactor: HomeInteractorToPresenter!
    var router: HomeRouterToPresenter!
    private var pagination = false
    private var products:[ProductModel] = []
    
}

extension HomePresenter:HomePresenterToView{

    func fetchProducts() {
        guard !pagination else {
            return
        }
        pagination = true
        
        view.showLoading()
        
        
        let datasource = Connectivity.shared.isConnected ? DatasourceFactory.buildDataSource(type: .Online) : DatasourceFactory.buildDataSource(type: .Offline)
        
        interactor.fetchProducts(datasource: datasource)
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
    func onViewWillAppear() {
        Connectivity.shared.addListener(listener: self)
        self.pagination = false
        fetchProducts()

    }
    
}


extension HomePresenter: HomePresenterToInteractor{
    
    func onFinishFetching(withData data: [ProductModel]) {
        guard !data.isEmpty else {
            let message = "No Internet connection or chached data to be displayd, please connect to the internet and try again ..."
            router.navigateToPopupInfo(message: message) {
                self.router.navigateToConnectionIssue()
            }
            return
        }
        view.hideLoading()
        products += data
        view.onFinishFetching()
    }
    
    func onFinishFetching(withError error: CustomError) {
        router.navigateToPopupError(message: error.description, completion: nil)
    }
    
    func onFinishCaching(withError error: CustomError) {
        router.navigateToPopupInfo(message: error.description, completion: nil)
        
    }
}


extension HomePresenter:ConnectionNotifiable{
    func connection(status: ConnectionStatus) {
        switch status {
            case .Online:
                router.navigateToOnlineToast()
                fetchProducts()
            case .Offline:
                router.navigateToOfflineToast()
        }
    }
}
