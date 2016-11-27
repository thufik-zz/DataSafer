//
//  Operation.swift
//  DataSafer
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 26/11/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import ObjectMapper

class Operation: Mappable {

    var nome : String?
    var inicio : String?
    var intervalo : Int?
    var pasta : String?
    var ultimaOperacao : UltimaOperacao?
    
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        nome <- map["nome"]
        ultimaOperacao <- map["ultima_operacao"]
    }
    
    
      class UltimaOperacao : Mappable{
        
        var data: String?
        var status : String?
        var tamanho : Int?
        
        required init?(_ map : Map) {}
    
        func mapping(map: Map) {
            data <- map["data"]
            status <- map["status"]
            tamanho <- map["tamanho"]
        }
        
    }
}
