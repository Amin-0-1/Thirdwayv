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

    init(datasource:Datasourceable){
        self.datasource = datasource
    }
    
    func fetchProducts() {

        datasource.fetch { [weak self] model in
            guard let self = self else {return}
            switch model{
                case .success(let model):
                    self.presenter.onFinishFetching(withData: model)
                case .failure(let error):
                    print(error.description)
            }
        }
    }
    
    
}


