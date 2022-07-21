//
//  Service.swift
//  RickAndMarty
//
//  Created by İSMAİL AÇIKYÜREK on 19.07.2022.
//


import Foundation
import Alamofire

//MARK: Protocol
protocol RickAndMortyServiceProtokol {
    func fethAllPosts(url:String,onSuccess: @escaping (RickAndMortyModel) -> Void, onFail: @escaping (String?) -> Void)
}

//MARK: Get Datas
struct RickAndMortyService: RickAndMortyServiceProtokol {
    func fethAllPosts(url:String,onSuccess: @escaping (RickAndMortyModel) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of: RickAndMortyModel.self) { (response) in
            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
}
