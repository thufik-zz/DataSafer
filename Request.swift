//
//  GetUser.swift
//  DataSafer
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 22/10/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import Alamofire
import FCAlertView
import ALLoadingView
import ObjectMapper

class Request: NSObject {

    
    private static var endPoint = "http://senai.datasafer.com.br/"
    
    
    static func getHosts(success: (response: AnyObject!) -> Void, failure: (error: NSError?) -> Void){
     
        let url = NSMutableURLRequest(URL: NSURL(string: endPoint + "gerenciamento/usuario/estacoes")!)
        
        
        let header = ["Authorization" : AppDelegate.token.token, "content-type" : "application/json"]
        
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: header).responseArray(completionHandler: { (response: Response<[Host],NSError>) in
            
            switch response.result {
        
            case .Success:
                success(response : response.result.value)
            case .Failure(let error):
                failure(error: error)
                
            }
            
        })
    }
    
    static func getBackups(host: Host, success : (response : AnyObject!) -> Void, failure : (error : NSError?) -> Void){
        
        
        let url = NSMutableURLRequest(URL: NSURL(string: endPoint + "gerenciamento/estacao/backups")!)
        
        let header =
        [
                "authorization" : AppDelegate.token.token,
                "content-type" : "application/json",
                "estacao" : host.nome!
        ]
        
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: header).responseArray(completionHandler: { (response : Response<[Operation],NSError>) in
            
            switch response.result{
                
            case .Success :
                    success(response: response.result.value)
            case .Failure(let error) :
                    failure(error: error)
            }
            
        })
        
        
    }
    
    static func getUserAndToken(user : String, pass: String, success : (response : AnyObject) -> Void, failure : (error : NSError?) -> Void){

        let url = NSMutableURLRequest(URL: NSURL(string: endPoint + "gerenciamento/login")!)
        
        let parameters = [
            "login" : user,
            "senha" : pass,
            "expira" : false
        ]
        
        
        let header = [
            "content-type" : "application/json",
            "accept" : "application/json"
        ]
        
        Alamofire.request(.POST, url, parameters: parameters as? [String : AnyObject], encoding: .JSON, headers: header).responseJSON(completionHandler: { (response) -> Void in
            
            switch response.result{
                case .Success :
                    
                    AppDelegate.token.token = response.result.value!["token"] as! String
                    self.putTokenIOS()
                    
                    self.getUser(response.result.value!["token"] as! String, success: { (sucesso) -> Void in
                        
                        success(response: sucesso)
                        
                    },failure : { (error) -> Void in
                    
                        failure(error: error)
                    })
                break
                case .Failure(let error) :
                    failure(error: error)
            }
            
        })
        
    }
    
    static func getUser(token: String,success : (response : AnyObject) -> Void, failure : (error : NSError?) -> Void)
    {
        
        let url = NSMutableURLRequest(URL: NSURL(string: endPoint + "gerenciamento/usuario")!)
        
        let header = [
            "Authorization" : token,
            "content-type" : "application/json"
        ]
        
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: header).responseObject(completionHandler: { (response: Response<User,NSError> ) in
            
            switch response.result{
                
            case .Success :
                success(response: response.result.value!)
            case .Failure(let error) :
                failure(error: error)
            }
            
        })
    }
    
    static func putTokenIOS()
    {
        let url = NSMutableURLRequest(URL: NSURL(string: endPoint + "gerenciamento/notificacoes")!)
        let header = [
            "Authorization" : AppDelegate.token.token,
            "content-type" : "application/json"
        ]
        
        let parameters = [
            "token" : AppDelegate.token.iosToken,
            "tipo" : "DISPOSITIVO_IOS"
        ]
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers: header)
    }
    
    
    
}
