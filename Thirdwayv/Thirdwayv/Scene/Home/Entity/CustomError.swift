//
//  HomeCustomError.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import Foundation

enum CustomError:Error{
    case ServerError
    case InternetError
    case ParsingError
    case error(String)
}

extension CustomError{
    var description:String{
        switch self {
            case .InternetError:
                return "No Internet Connection..."
            case .error(let string):
                return string
            default:
                return "An Error Occured, Please try again later..."
        }
    }
}
