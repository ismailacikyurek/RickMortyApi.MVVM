//
//  RickAndMartViewModel.swift
//  RickAndMarty
//
//  Created by İSMAİL AÇIKYÜREK on 19.07.2022.


import UIKit
import Alamofire


protocol DashboardViewModelProtocol {
    func initialize()
    func setUpDelegate(_ viewController: RickAndMortyViewController)
    func getImage(from string: String) -> UIImage?
}

protocol DashboardViewModelOutputProtocol {
    func showData(content: RickAndMortyModel)
}

class DashboardViewModel:NSObject {
    private let service: RickAndMortyServiceProtokol = RickAndMortyService()
    var delegate: DashboardViewModelOutputProtocol?

    func initialize() {
        RickAndMortyServicee()
    }
    
     func RickAndMortyServicee() {
        let url = "https://rickandmortyapi.com/api/character"
        service.fethAllPosts(url: url) { [weak self] model in
            self?.delegate?.showData(content: model)
            
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
    }
}

extension DashboardViewModel: DashboardViewModelProtocol {
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
    
    func setUpDelegate(_ viewController: RickAndMortyViewController) {
        delegate = viewController
    }
    
}

