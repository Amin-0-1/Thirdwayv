//
//  PopupMessage.swift
//  Thirdwayv
//
//  Created by Amin on 17/12/2022.
//

import UIKit

enum PopupState:String{
    case Info = "info.circle.fill"
    case Error = "xmark.circle.fill"
}
class PopupMessage: UIViewController {

    @IBOutlet private weak var uiImage: UIImageView!
    @IBOutlet private weak var uiLabel: UILabel!
    
    private var completion:(()->Void)?
    private var state:PopupState!
    private var message:String!
    func configure(state:PopupState,message:String,completion:(()->Void)?){
        self.state = state
        self.message = message
        self.completion = completion
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        switch state {
            case .Info:
                uiImage.image = UIImage(systemName: state.rawValue)
                uiImage.tintColor = .systemBlue
            case .Error:
                uiImage.image = UIImage(systemName: state.rawValue)
                uiImage.tintColor = .red
            case .none:
                break
        }
        uiLabel.text = message

    }
    @IBAction func uiCloseTapped(_ sender: Any) {
        self.dismiss(animated: true)
        guard let completion = completion else {return}
        completion()
    }
    @IBAction func uiOkTapped(_ sender: Any) {
        self.dismiss(animated: true)
        guard let completion = completion else {return}
        completion()
    }
}
