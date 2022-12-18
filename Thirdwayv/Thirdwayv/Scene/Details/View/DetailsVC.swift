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
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Home", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backSelector))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        setupSwipe()
    }
    
    private func setupSwipe(){
        let ges = UISwipeGestureRecognizer(target: self, action: #selector(swipeSelector))
        ges.direction = .right
        self.view.addGestureRecognizer(ges)
    }
    @objc private func swipeSelector(){
        self.dismissView()
    }
    @objc private func backSelector(sender: UIBarButtonItem) {
        self.dismissView()
    }
    
    private func dismissView(){
        let transition = CATransition()
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromTop
        self.view.window?.layer.add(transition, forKey: nil)
        
        navigationController?.popViewController(animated: false)
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
