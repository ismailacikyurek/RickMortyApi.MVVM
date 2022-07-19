//
//  ViewController.swift
//  RickAndMarty
//
//  Created by İSMAİL AÇIKYÜREK on 19.07.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var model : RickAndMartyModel?
    let viewModel : DashboardViewModelProtocol = DashboardViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setUpDelegate(self)
        viewModel.initialize()
        
       
    
        
        let tasarim : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = self.collectionView.frame.size.width
     
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.itemSize = CGSize(width: (genislik-70)/2, height: (genislik-50)/1)
        tasarim.minimumLineSpacing = 10
        tasarim.minimumInteritemSpacing = 1
        collectionView.collectionViewLayout = tasarim
    }
    
    
    func getImage(from string: String) -> UIImage? {
        //2. Get valid URL
        guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                return nil
        }

        var image: UIImage? = nil
        do {
            //3. Get valid data
            let data = try Data(contentsOf: url, options: [])

            //4. Make image
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }

        return image
    }

  
   

}

extension ViewController: DashboardViewModelOutputProtocol {
    func showData(content: RickAndMartyModel) {
        DispatchQueue.main.async { [self] in //2 saniye bekletip, tabloyu öyle yükledim. Aksi halde 1 veya 2 tane geliyor.
            model = content
           collectionView.reloadData()
        }
       
}}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate{
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.lblNAme.text = model?.results![indexPath.row].name
      
        if let string = model?.results![indexPath.row].image {
            if let image = getImage(from: string) {
                cell.imageView.image = image
            }
        }
      
      cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

