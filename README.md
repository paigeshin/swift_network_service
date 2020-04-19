# swift_network_service

기본적으로 ios 에서 재공하는 Codable, URLSessionTask는 코드량이 너무 많다.
게다가 encoding, decoding 하는 부분에서 한 가지만 놓쳐도 에러가 날 가능성이 너무 높음
그래서 ios developer들이 자주 사용하는 library 를 공부

# 나의 choice

## 매우 복잡한 큰 서비스
 - Alamofire, Promisekit, ObjectMapper

## 복잡하지 않은 적당한 크기의 서비스
- Alamofire, SwiftyJson, ios에서 제공하는 semaphore   *개발 속도 제일 빠름

# Object Mapper

- struct 나 class로 data strcture 잡아주고 jsonString 던지면 알아서 mapping 해줌
- 아래 예제는 class이지만 웬만하면 call by value인 `struct`를 사용하자.

        import ObjectMapper

        class ActorAPIResponse: Mappable {
            
            var actors: [Actor]?
            
            required init?(map: Map) {
                
            }
            
            func mapping(map: Map) {
                actors <- map["actors"]
            }
            
        }

        class Actor: Mappable {
            
            var name: String?
            var des: String?
            var country: String?
            var spouse: String?
            var imageUrl: String?
            
            required init?(map: Map) {
                
            }
            
            func mapping(map: Map) {
                name <- map["name"]
                des <- map["description"]
                spouse <- map["spouse"]
                country <- map["country"]
                imageUrl <- map["image"]
            }
            
        }


# Alamofire, Promisekit

- singleton 


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


# Alamofire, promisekit 사용

    let apiCall = APIManager.shared.fetchActorsFromApi()
    let _ = apiCall.done { (actors) in
        self.dataSourceArr = actors
        self.tableView.reloadData()
    }
