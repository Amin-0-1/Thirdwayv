//
//  HomeVC.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import UIKit


protocol HomeViewToPresenter: AnyObject{
    func onFinishFetching()
    func showLoading()
    func hideLoading()
}
class HomeVC: UIViewController {
    
    @IBOutlet weak var uiCollection: UICollectionView!
    var presenter:HomePresenterToView!
    
    private var isLoading:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureCollection()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewWillAppear()
    }
    private func configureNavigation(){
        title = "Product List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func configureCollection(){
        let productNib = UINib(nibName: ProductCell.nibName, bundle: nil)
        uiCollection.register(productNib, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        
        if let layout = uiCollection?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
    
    
}

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell else {fatalError("Unable to dequeue cell\(ProductCell.reuseIdentifier)")}
        cell.configure(withModel: presenter.getModel(forIndexPath: indexPath.item))
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {    
        presenter.didSelectItem(at:indexPath.item)
    }
        
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let animationDuration: Double = 0.5
            cell.alpha = 0.1
            cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: animationDuration, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: [], animations: {
                cell.alpha = 1
                cell.transform = .identity
            })
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.contentView.layer.removeAllAnimations()
    }
}
extension HomeVC: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
            return CGFloat(presenter.getImageHeight(forIndex: indexPath.item))
        }
}

extension HomeVC:HomeViewToPresenter{
    func showLoading() {
        self.startLoading()
    }
    
    func hideLoading() {
        self.stopLoading()
    }
    
    func onFinishFetching() {
        uiCollection.reloadData()
        presenter.stopPaginating()
    }
}

extension HomeVC:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (uiCollection.contentSize.height-10-scrollView.frame.height){
            
            
            guard !presenter.isPaginating() else {return}
            presenter.fetchProducts()
            
        }
    }
}
