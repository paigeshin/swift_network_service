//
//  ActorAPIResponse.swift
//  swift_webservice
//
//  Created by shin seunghyun on 2020/04/19.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

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
