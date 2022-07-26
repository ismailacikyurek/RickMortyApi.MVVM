//
//  ViewController.swift
//  RickAndMarty
//
//  Created by İSMAİL AÇIKYÜREK on 19.07.2022.
//

import UIKit
import Alamofire
import Kingfisher

class RickAndMortyViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var model : RickAndMortyModel?
    let viewModel : DashboardViewModelProtocol = DashboardViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setUpDelegate(self)
        viewModel.initialize()
        
        let design : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width1 = self.collectionView.frame.size.width
     
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.itemSize = CGSize(width: (width1-110)/2, height: (width1-50)/1)
        design.minimumLineSpacing = 10
        design.minimumInteritemSpacing = 1
        collectionView.collectionViewLayout = design
    }
}


extension RickAndMortyViewController: DashboardViewModelOutputProtocol {
    func showData(content: RickAndMortyModel) {
        model = content
       collectionView.reloadData()
}}

extension RickAndMortyViewController : UICollectionViewDataSource,UICollectionViewDelegate{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = self.model?.results else { return 0 }
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        guard let content = model?.results?[indexPath.row] else { return UICollectionViewCell()}
        cell.configure(content: content)
      
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

