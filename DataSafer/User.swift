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
    var statusBackups : Statusbackups?
    var armazenamento : Int?
    var armazenamentoOcupado : Int?
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        name <- map["nome"]
        mail <- map["email"]
        storage <- map["armazenamento"]
        statusBackups <- map["status_backups"]
        armazenamento <- map["armazenamento"]
        armazenamentoOcupado <- map["armazenamento_ocupado"]
    }
    
    
    
    class Statusbackups : Mappable {
        
        
        var executando : Int?
        var restaurado : Int?
        var agendado: Int?
        var restaurar: Int?
        var executado: Int?
        var falha: Int?
        var restaurando : Int?
        
        required init?(_ map : Map) {}
        
        func mapping(map: Map) {
            
            executando <- map["EXECUTANDO"]
            restaurado <- map["RESTAURADO"]
            agendado <- map["AGENDADO"]
            restaurar <- map["RESTAURAR"]
            executado <- map["EXECUTADO"]
            falha <- map["FALHA"]
            restaurando <- map["RESTAURANDO"]
        }
    }
    
}
