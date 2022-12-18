//
//  HomeInteractor.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import Foundation

protocol HomeInteractorToPresenter{
    func fetchProducts()
}

class HomeInteractor:HomeInteractorToPresenter{
    weak var presenter: HomePresenterToInteractor!
    private var datasource: Datasourceable!
    private var group : DispatchGroup!
    private var readyProducts : [ProductModel] = []
    
    init(datasource:Datasourceable){
        self.datasource = datasource
        group = DispatchGroup()
    }
    
    func fetchProducts() {
        datasource.fetch { [weak self] model in
            guard let self = self else {return}
            switch model{
                case .success(let model):
                    if Connectivity.shared.isConnected{
                        // fetched from api
                        self.resetLocalData()
                        self.prepareImages(forProducts: model)
                    }else{
                        // fetched from core data
                        self.presenter.onFinishFetching(withData: model)
                    }
                    
                case .failure(let error):
                    self.presenter.onFinishFetching(withError: error)
                    print(error.description)
            }
        }
    }
    private func prepareImages(forProducts products: [ProductModel]){
        readyProducts = products
        for (i,_) in readyProducts.enumerated(){
            group.enter()
            if let url = readyProducts[i].image?.url{
                if let url = URL(string: url){
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url) {
                            self.readyProducts[i].image?.imageData = data
                        }
                        self.group.leave()
                    }
                }
            }
        }
        group.notify(queue: .global()){
            DispatchQueue.main.async {
                self.presenter.onFinishFetching(withData: self.readyProducts)
            }
            
            self.cacheDataLocally(products: self.readyProducts)
        }
        
    }
    private func cacheDataLocally(products:[ProductModel]){
        //MARK: cache only for one time
        let local = LocalDatasource(type: .PROD)
        
//        local.fetch { result in
//            switch result{
//                case .failure(let error):
//                    self.presenter.onFinishCaching(withError: error)
//                case .success(let products):
//                    if products.isEmpty{
                        local.save(products: self.readyProducts) { error in
                            guard let error = error else {
                                return
                            }
                            self.presenter.onFinishCaching(withError: error)
                        }
//                    }
//            }
//        }
    }
    
    private func resetLocalData(){
        LocalDatasource(type: .PROD).resetLocal()
    }
    
    
}


