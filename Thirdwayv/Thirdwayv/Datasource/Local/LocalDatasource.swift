//
//  LocalDatasource.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import Foundation
import CoreData

class LocalDatasource:Datasourceable{
    
    private var coreDate : CoreDataStack!
    private lazy var background: NSManagedObjectContext  = {
        coreDate.backgroundContext
    }()
    private lazy var main:NSManagedObjectContext = {
        coreDate.mainContext
    }()
    init(type:CoreDataStackType){
        coreDate = CoreDataStack(type: type)
    }
    
    func save(products:[ProductModel],completion:@escaping (CustomError?)->Void) {
        background.perform {
            products.forEach { product in
                let new = ProductEntity(context: self.background)
                new.id = Int16(product.id ?? Int.random(in: 1...20))
                new.price = Float(product.price ?? Int.random(in: 100...1000))
                new.desc = product.productDescription
                new.imageHeigh = Int16(product.image?.height ?? Int.random(in: 200...5000))
                new.image = product.image?.imageData
            }
            
            do{
                try self.background.save()

                self.main.perform {
                    completion(nil)
                }
            }catch{
                let error = CustomError.error(error.localizedDescription)
                completion(error)
            }
        }
    }
    
    func fetch(completion: @escaping (Result<[ProductModel], CustomError>) -> Void) {
        background.performAndWait {
            let fetchReq: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
            do{
                let allReq = try fetchReq.execute()
                var products : [ProductModel] = []
                allReq.forEach { hit in
                    let image = Image(width: nil, height: Int(hit.imageHeigh), url: nil,imageData: hit.image)
                    let product = ProductModel(id: Int(hit.id),
                                               productDescription: hit.desc,
                                               image: image, price: Int(hit.price))
                    products.append(product)
                }
                self.main.perform {
                    completion(.success(products))
                }
            }catch{
                completion(.failure(.error(error.localizedDescription)))
            }
        }
    }
    

    func resetLocal(){
        coreDate.restore()
    }
    
}
