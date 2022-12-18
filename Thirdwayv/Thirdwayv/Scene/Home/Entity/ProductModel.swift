//
//  ProductModel.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import UIKit

struct ProductModel: Codable {
    let id: Int?
    let productDescription: String?
    var image: Image?
    let price: Int?
    
}

struct Image: Codable {
    let width, height: Int?
    let url: String?
    var imageData:Data?
}

