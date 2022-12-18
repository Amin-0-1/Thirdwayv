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
        uiTitle.text = "\(model.price ?? Int.random(in: 100...1000))$"
        
        guard let image = model.image?.imageData else {return}
        uiImage.image = UIImage(data: image)

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        uiContainerView.layer.cornerRadius = 20
        uiImage.roundCorners(corners: [.topLeft,.topRight], radius: 20)
        
        uiContainerView.layer.borderColor = UIColor.systemGray.cgColor
        uiContainerView.layer.borderWidth = 0.3
        uiContainerView.layer.shadowColor = UIColor.systemGray.cgColor
        uiContainerView.layer.shadowRadius = 1
        uiContainerView.layer.shadowOpacity = 0.8
        uiContainerView.layer.shadowOffset = CGSize(width: 5, height: 5)
    }

}

