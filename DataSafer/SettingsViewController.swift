//
//  SettingsViewController.swift
//  DataSafer
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 12/11/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import Alamofire

class SettingsViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMail: UILabel!
    @IBOutlet weak var lblAvailable: UILabel!
 
    @IBOutlet weak var lblUsed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func configView(){
        
        self.lblName.text = AppDelegate.token.user?.name!
        self.lblMail.text = AppDelegate.token.user?.mail!
        self.lblAvailable.text = StorageAvailable()
        self.lblUsed.text = StorageUsed()
        self.view.backgroundColor = Cores.appBackgroundColor
        
    }
    
    
    private func StorageAvailable() -> String
        
    {
        let StorageAvailable = (Float(AppDelegate.token.user!.armazenamento!))
        
        
        
        return String(format: "%.2f GBytes",(StorageAvailable / 1024.0 / 1024.0))
    }
    
    private func StorageUsed() -> String
    {
        let storageUsed = Float(AppDelegate.token.user!.armazenamentoOcupado!)
        let kb =  1024.0 as Float
        let mb = kb * 1024.0 as Float
        let gb = mb * 1024.0 as Float
        
        
        if (storageUsed < kb)
        {
            return "\(storageUsed) Bytes"
        }
        else if (storageUsed >= kb && storageUsed <= mb)
        {
            return String(format: "%.2f KBytes",(storageUsed / kb))
        }
        else if (storageUsed >= mb && storageUsed <= gb)
        {
            return String(format: "%.2f MBytes",(storageUsed / mb))
        }
        else
        {
            return String(format: "%.2f GBytes",(storageUsed / gb))
        }
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
