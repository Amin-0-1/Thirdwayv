//
//  ReusableView.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import UIKit

protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

//extension UICollectionViewCell: ReusableView {}
extension UICollectionReusableView: ReusableView{}
