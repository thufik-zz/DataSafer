//
//  Host.swift
//  DataSafer
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 29/10/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
//import ObjectMapper
import ObjectMapper

class Host: Mappable {

    var nome: String?
    var operation : Operation?
    
    required init?(_ map: Map){}
    
    func mapping(map : Map){
        
        nome <- map["nome"]
        operation <- map["operacoes"]
        
    }
    
    class Operation: Mappable {
        
        var falha :  Int?
        var agendado : Int?
        var executando : Int?
        var excluido : Int?
        var sucesso : Int?
        
        required init?(_ map: Map) {
            
        }
        
        func mapping(map: Map) {
            falha <- map["falha"]
            agendado <- map["agendado"]
            executando <- map["executando"]
            excluido <- map["excluido"]
            sucesso <- map["sucesso"]
        }
        
        
        
    }
    
}
