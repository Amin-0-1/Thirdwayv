//
//  NibLoadableView.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import UIKit
protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

//extension UICollectionViewCell : NibLoadableView {}
extension UICollectionReusableView: NibLoadableView{}
