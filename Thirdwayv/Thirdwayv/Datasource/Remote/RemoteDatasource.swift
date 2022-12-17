//
//  RemoteDatasource.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import Foundation

class RemoteDatasource:Datasourceable{
    private static let url = "https://mocki.io/v1/649f7b2e-adec-496a-b140-6c26817c8ad3"

    func fetch(completion: @escaping (Result<[ProductModel],CustomError>) -> Void) {
        guard let url = URL(string: Self.url) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            if let err = err {
                let error: CustomError = .error(err.localizedDescription)
                completion(.failure(error))
            }else if let data = data {
                if let decoded = try? JSONDecoder().decode([ProductModel].self, from: data) {
                    DispatchQueue.main.async {
                        completion(.success(decoded))
                    }
                    return
                }
                completion(.failure(.ParsingError))
            }else{
                completion(.failure(.InternetError))
            }
        }.resume()
    }
    
}
