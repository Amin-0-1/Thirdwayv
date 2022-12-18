//
//  DetailsVC.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import UIKit

class DetailsVC: UIViewController {

 
    @IBOutlet var uiImage: UIImageView!
    @IBOutlet var uiImageView: UIView!
    @IBOutlet var uiTitle: UILabel!
    @IBOutlet var uiDescription: UILabel!
 
    
    var presenter:DetailsPresenterToView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        setupImage()
        if let image = presenter.getImageData(){
            uiImage.image = UIImage(data: image)
        }else{
            uiImage.image = UIImage(systemName: "rectangle.fill.on.rectangle.fill")
        }
        
        uiTitle.text = "\(presenter.getPrice())$"
        uiDescription.text = "\(presenter.getDesc())"
        
    }
    func setupImage() {
        
        uiImageView.layer.borderWidth = 0.3
        uiImageView.layer.cornerRadius = 25
        uiImage.layer.cornerRadius = 25
        uiImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        uiImageView.layer.shadowRadius = 1
        uiImageView.layer.shadowOpacity = 0.8
        uiImageView.layer.masksToBounds = false
    }
}
