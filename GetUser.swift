//
//  GetUser.swift
//  DataSafer
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 22/10/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import Alamofire
//import FCAlertView
//import ALLoadingView

class GetUser: NSObject {

    
    static func Login(user:String, pass:String){
        
        //let url = NSMutableURLRequest(url: URL(string: "http://giovannic.ddns.net:7070/Datasafer/gerenciamento/login")!)
        
        let url = NSMutableURLRequest(URL: NSURL(string: "http://giovannic.ddns.net:7070/Datasafer/gerenciamento/login")!)
        
        let parameters = [
            
                "login" : user,
                "senha" : pass,
                "expira" : false
        ]
        
        let header = [
            "content-type" : "application/json",
            "accept" : "application/json"
        ]
        
        
        //ALLoadingView.manager.blurredBackground = true
        //let loadingview = ALLoadingView()
        //let alert = FCAlertView()
        //alert.makeAlertTypeWarning()
        //loadingview.showLoadingViewOfType(.messageWithIndicator, windowMode: .fullscreen)
        //loadingview.showLoadingViewOfType(.MessageWithIndicator, windowMode: .Fullscreen)
        
        //Alamofire.reque
        
        //Alamofire.req
        
        Alamofire.request(.POST, url, parameters: parameters as? [String : AnyObject], encoding: .JSON, headers: header).responseJSON(completionHandler: { (response) -> Void in
        
            if let JsonReturn = response.result.value as? [String : AnyObject]{
                
                if JsonReturn["erro"] != nil
                {
                    //loadingview.hideLoadingView()
                    //alert.showAlert(withTitle: "Atenção", withSubtitle: "Usuário ou senha incorretos", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
                }
                else
                {
                    //loadingview.hideLoadingView()
                    AppDelegate.token.token = JsonReturn["token"] as! String
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let menu = storyboard.instantiateViewControllerWithIdentifier("menu")
                    //let menu = storyboard.instantiateViewController(withIdentifier: "menu")
                    (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = menu
                    //(UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = menu
                    
                }
            }
            else
            {
                //loadingview.hideLoadingView()
                //alert.showAlert(withTitle: "Atenção", withSubtitle: "Houve um erro, tente novamente mais tarde", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
            }
        
        })
        

        
    }
    

}
