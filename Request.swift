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

class Request: NSObject {

    
    static func getHosts(success: (response: AnyObject!) -> Void, failure: (error: NSError?) -> Void){
     
        let url = NSMutableURLRequest(URL: NSURL(string: "http://senai.datasafer.com.br/gerenciamento/usuario/estacoes")!)
        
        let header = ["Authorization" : AppDelegate.token.token, "content-type" : "application/json"]
        
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: header).responseArray(completionHandler: { (response: Response<[Host],NSError>) in
            
           
            print(response.debugDescription)
            
            switch response.result{
                
            case .Success:
                success(response : response.result.value)
            case .Failure(let error):
                failure(error: error)
                
            }
            
        })
    }
    
    static func getBackups(host: Host, success : (response : AnyObject!) -> Void, failure : (error : NSError?) -> Void){
        
        
        let url = NSMutableURLRequest(URL: NSURL(string: "http://senai.datasafer.com.br/gerenciamento/estacao/backups")!)
        
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
    
    static func getToken(user : String, pass: String, success : (response : AnyObject) -> Void, failure : (error : NSError?) -> Void){

        let url = NSMutableURLRequest(URL: NSURL(string: "http://senai.datasafer.com.br/gerenciamento/login")!)
        
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
        
        let url = NSMutableURLRequest(URL: NSURL(string: "http://senai.datasafer.com.br/gerenciamento/usuario")!)
        
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
    
    
//    static func Login(user:String, pass:String){
//        
//        let url = NSMutableURLRequest(URL: NSURL(string: "http://senai.datasafer.com.br/gerenciamento/login")!)
//
//        let parameters = [
//                "login" : user,
//                "senha" : pass,
//                "expira" : false
//        ]
//        
//        let header = [
//            "content-type" : "application/json",
//            "accept" : "application/json"
//        ]
//        
//        
//        //let loadingview = ALLoadingView()
//        //let alert = FCAlertView()
//        //loadingview.showLoadingViewOfType(.Default, windowMode: .Fullscreen)
//        
//        Alamofire.request(.POST, url, parameters: parameters as? [String : AnyObject], encoding: .JSON, headers: header).responseJSON(completionHandler: { (response) -> Void in
//        
//            if let JsonReturn = response.result.value as? [String : AnyObject]
//            {
//                
//                if JsonReturn["erro"] != nil
//                {
//                    loadingview.hideLoadingView()
//                    alert.makeAlertTypeCaution()
//                    alert.showAlertWithTitle("Atenção", withSubtitle: "Usuário ou senha incorretos", withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
//                }
//                else
//                {
//                    loadingview.hideLoadingView()
//                    AppDelegate.token.token = JsonReturn["token"] as! String
//                    print("token = \(AppDelegate.token.token)")
//                    
//                    
//                    
//                    let url = NSMutableURLRequest(URL: NSURL(string: "http://senai.datasafer.com.br/gerenciamento/usuario")!)
//                    
//                    let header = ["authorization" : AppDelegate.token.token,"content-type" : "application/json"]
//                    
//                    
//                    Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: header).responseObject(completionHandler: { (response: Response<User,NSError> ) in
//                        
//                        if let responseData = response.result.value
//                        {
//                            
//                            AppDelegate.token.user = responseData
//                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                            let menu = storyboard.instantiateViewControllerWithIdentifier("menu")
//                            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = menu
//                            
//                        }
//                        else
//                        {
//                            print(response.response.debugDescription)
//                        }
//                        
//                    })
//                }
//            }
//            else
//            {
//                loadingview.hideLoadingView()
//                alert.makeAlertTypeCaution()
//                alert.showAlertWithTitle("Atenção", withSubtitle: "Houve um erro, tente novamente mais tarde", withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
//            }
//        
//        })
//        
//
//        
//    }
    

}
