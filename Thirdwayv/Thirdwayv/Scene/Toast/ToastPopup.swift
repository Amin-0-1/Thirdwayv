//
//  ToastPopup.swift
//  Thirdwayv
//
//  Created by Amin on 18/12/2022.
//

import UIKit

enum ToastImage:String{
    case Error = "x.circle.fill"
    case Info = "info.circle.fill"
    case Warning = "exclamationmark.triangle.fill"
    case Success = "checkmark.circle.fill"
}
class ToastPopup: UIViewController {
    
    @IBOutlet private weak var uiImage: UIImageView!
    @IBOutlet private weak var uiDesc: UILabel!
    
    
    private var image:ToastImage!
    private var descText:String!
    private var duration:Double!
    func configure( _ desc:String,_ image:ToastImage,_ dismissAfter:Int = 3){
        self.image = image
        self.descText = desc
        self.duration = Double(dismissAfter)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        prepareGesture()
        Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(dismissVC), userInfo: nil, repeats: false)
    }
    
    private func prepareView(){
        uiImage.image = UIImage(systemName: image.rawValue)
        uiDesc.text = descText
    }
    private func prepareGesture(){
        let gest = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        self.view.addGestureRecognizer(gest)
    }

    @objc private func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
