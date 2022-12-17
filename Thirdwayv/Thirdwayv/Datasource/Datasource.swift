//
//  Datasource.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import Foundation

enum DatasourceState{
    case Online
    case Offline
}

protocol Datasourceable{
    func fetch(completion: @escaping (Result<[ProductModel],CustomError>) -> Void)
}

class DatasourceFactory{
    static func buildDataSource(type:DatasourceState)->Datasourceable{
        switch type {
            case .Online:
                return RemoteDatasource()
            case .Offline:
                return LocalDatasource()
        }
    }
}
