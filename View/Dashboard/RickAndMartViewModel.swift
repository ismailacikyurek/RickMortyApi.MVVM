//
//  RickAndMartViewModel.swift
//  RickAndMarty
//
//  Created by İSMAİL AÇIKYÜREK on 19.07.2022.


import UIKit
import Alamofire


protocol DashboardViewModelProtocol {
    func initialize()
    func setUpDelegate(_ viewController: ViewController)
 
}

protocol DashboardViewModelOutputProtocol {
    func showData(content: RickAndMartyModel)
}

class DashboardViewModel:NSObject {
    private let service: RickAndMartyServiceProtokol = RickAndMartyService()
    var delegate: DashboardViewModelOutputProtocol?

    func initialize() {
        RickAndMartyServicee()
    }
    
     func RickAndMartyServicee() {
        let url = "https://rickandmortyapi.com/api/character"
        service.fethAllPosts(url: url) { [weak self] model in
            self?.delegate?.showData(content: model)
            
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
    }
}

extension DashboardViewModel: DashboardViewModelProtocol {
    func setUpDelegate(_ viewController: ViewController) {
        delegate = viewController
    }
    
}
