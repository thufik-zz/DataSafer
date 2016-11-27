//
//  User.swift
//  DataSafer
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 12/11/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Mappable {

    var name: String?
    var mail : String?
    var storage : Int?
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        name <- map["nome"]
        mail <- map["email"]
        storage <- map["armazenamento"]
    }
}
