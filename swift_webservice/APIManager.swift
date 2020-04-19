//
//  APIManager.swift
//  swift_webservice
//
//  Created by shin seunghyun on 2020/04/19.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class APIManager {
    
    static let shared = APIManager()
    
    private init() {
        
    }
    
    func fetchActorsFromApi() -> Promise<[Actor]>{
        
        return Promise { resolver in
            return AF.request(API_URL).responseString { (response) in
                
                switch response.result {
                    
                    case .success(let data):
                    let actorResponse = ActorAPIResponse(JSONString: "\(data)")
                        resolver.fulfill((actorResponse?.actors)!)
                    case .failure(let error):
                        resolver.reject(error)
                        print(error)
                    
                }
                
            }
        }
        

    }
    
}
