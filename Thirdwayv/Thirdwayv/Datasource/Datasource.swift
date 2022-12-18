//
//  Datasource.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import Foundation

enum DatasourceConnectionState{
    case Online
    case Offline
}

protocol Datasourceable{
    func fetch(completion: @escaping (Result<[ProductModel],CustomError>) -> Void)
    func save(products:[ProductModel],completion:@escaping (CustomError?)->Void)
}
extension Datasourceable{
    func save(products: [ProductModel], completion: @escaping (CustomError?) -> Void) {}
}


class DatasourceFactory{
    static func buildDataSource(type:DatasourceConnectionState)->Datasourceable{
        switch type {
            case .Online:
                return RemoteDatasource()
            case .Offline:
                return LocalDatasource(type: .PROD)
        }
    }
}
