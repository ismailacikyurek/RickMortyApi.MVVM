//
//  Service.swift
//  RickAndMarty
//
//  Created by İSMAİL AÇIKYÜREK on 19.07.2022.
//


import Foundation
import Alamofire

//MARK: Protocol
protocol RickAndMartyServiceProtokol {
    func fethAllPosts(url:String,onSuccess: @escaping (RickAndMartyModel) -> Void, onFail: @escaping (String?) -> Void)
}

//MARK: Get Datas
struct RickAndMartyService: RickAndMartyServiceProtokol {
    func fethAllPosts(url:String,onSuccess: @escaping (RickAndMartyModel) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of: RickAndMartyModel.self) { (response) in
            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
}
