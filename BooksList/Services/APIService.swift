//
//  APIService.swift
//  BooksList
//
//  Created by NB MacBook on 9/11/20.
//  Copyright © 2020 NB MacBook. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkCompletionBlock = (_ result: Any?, _ isSuccess: Bool, _ message: String?) -> Void

class APIService {
    
    public static var baseURL: String {
        return "https://api.nytimes.com/svc/books/v3"
    }

    private struct Constants {
        static let listsURL: String = APIService.baseURL.appending("/lists/overview.json")
        static let namesURL: String = APIService.baseURL.appending("/lists/names.json")
    }
    
    static let shared = APIService()
    
    static let token: String = "0HaSjsFPnbXAJx3n13UpJ5F5hG1G8brq"
    
    var requestHeader: HTTPHeaders? {
        return ["Content-Type" : "application/json", "Accept" : "application/json"]
    }
    
    func getLists(completion:@escaping NetworkCompletionBlock) {
        print("[API] getLists")
        let parameters: Parameters = ["api-key": APIService.token]
        AF.request(Constants.listsURL, method: .get, parameters: parameters, headers: requestHeader).validate().responseDecodable(of: ListsResponseData.self) { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.value else { return }
                completion(data.results?.lists, true, nil)
            } else {
                let errorMessage = "Failed to fetch lists from server"
                completion(nil, false, errorMessage)
            }
        }
    }
    
    func getNames(completion:@escaping NetworkCompletionBlock) {
        print("[API] getNames")
        let parameters: Parameters = ["api-key": APIService.token]
        AF.request(Constants.namesURL, method: .get, parameters: parameters, headers: requestHeader).validate().responseDecodable(of: NamesResponseData.self) { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.value else { return }
                completion(data.lists, true, nil)
            } else {
                let errorMessage = "Failed to fetch names from server"
                completion(nil, false, errorMessage)
            }
        }
    }
}
