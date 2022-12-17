//
//  CollectionViewCell.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet private weak var uiContainerView: UIView!
    @IBOutlet private weak var uiTitle: UILabel!
    @IBOutlet private weak var uiImage: UIImageView!
    @IBOutlet private weak var uiDesc: UILabel!
    
    func configure(withModel model:ProductModel){
        uiDesc.text = model.productDescription
        uiTitle.text = "\(model.price)$"
        guard let url = URL(string: model.image.url) else {return}
        uiImage.load(url: url)
//        uiImage.loadFrom(URLAddress: model.image.url)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 6
        uiContainerView.layer.cornerRadius = 6
        uiImage.roundCorners(corners: [.topLeft,.topRight], radius: 6)
        
        uiContainerView.layer.borderColor = UIColor.systemGray.cgColor
        uiContainerView.layer.borderWidth = 0.3
        uiContainerView.layer.shadowColor = UIColor.systemGray.cgColor
        uiContainerView.layer.shadowOpacity = 0.3
        uiContainerView.layer.shadowOffset = CGSize(width: 5, height: 5)
    }

}

