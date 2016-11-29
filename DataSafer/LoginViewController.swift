//
//  LoginViewController.swift
//  DataSafer
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 9/10/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import FCAlertView


class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configLayout()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: UIButton) {
    
        self.validateFields()
    
    }
    
    func loadUser(user : String, pass : String){
        
        Request.getUserAndToken(user, pass: pass, success: { (userValue) -> Void in
            
                AppDelegate.token.user = userValue as? User
            
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let menu = storyboard.instantiateViewControllerWithIdentifier("menu")
                (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = menu
                
            }, failure: { (error : NSError?) -> Void in
        
                let alert = FCAlertView()
                alert.makeAlertTypeWarning()
                alert.showAlertWithTitle("Atenção", withSubtitle: "Erro ao logar", withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
        })
        
    }
    
    func validateFields()
    {
        if (self.txtLogin.text != "" && self.txtPass.text != ""){
            loadUser(txtLogin.text!, pass: txtPass.text!)
        }else{
            let alert = FCAlertView()
            alert.makeAlertTypeWarning()
            alert.showAlertWithTitle("Atenção", withSubtitle: "Preencha todos os campos", withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
            if self.txtLogin.text == ""{
                self.txtLogin.becomeFirstResponder()
            }else{
                self.txtPass.becomeFirstResponder()
            }
        }
    }
    
    
    func configLayout()
    {
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 10
        loginButton.backgroundColor = Cores.appColor
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
