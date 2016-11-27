//
//  SettingsViewController.swift
//  DataSafer
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 12/11/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import Alamofire
import MSSimpleGauge

class SettingsViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMail: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = NSMutableURLRequest(URL: NSURL(string: "http://senai.datasafer.com.br/gerenciamento/usuario")!)
        
        let header = ["authorization" : AppDelegate.token.token,"content-type" : "application/json"]
        
        
        self.view.backgroundColor = UIColor.init(red: 240.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        var x = MSSimpleGauge(frame: CGRect(x: 30, y: 370, width: 250, height: 125))
        
        x.backgroundArcFillColor = UIColor.redColor()
        x.fillArcFillColor = UIColor.greenColor()
        x.fillArcStrokeColor = UIColor.purpleColor()
    
        x.backgroundColor = Cores.appBackgroundColor
        
        self.view.addSubview(x)
        
        x.setValue(50.0, animated: true)
        x.maxValue = 100.0
        x.minValue = 0.0
        //x.setValue(50.0, forKey: "valor", animated: true)
        
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: header).responseObject(completionHandler: { (response: Response<User,NSError> ) in
            
            if let responseData = response.result.value
            {
                
                print(response.response.debugDescription)
                self.lblName.text = responseData.name!
                self.lblMail.text = responseData.mail!
            }
            else
            {
                print(response.response.debugDescription)
            }
            
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
