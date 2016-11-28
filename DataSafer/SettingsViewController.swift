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
        self.view.backgroundColor = Cores.appBackgroundColor
        self.view.addSubview(self.Graph())
    }
    
    private func Graph() -> MSSimpleGauge{
        
        let graph = MSSimpleGauge(frame: CGRect(x: 30, y: 370, width: 250, height: 125))
        
        graph.backgroundArcFillColor = UIColor.redColor()
        graph.fillArcFillColor = UIColor.greenColor()
        graph.fillArcStrokeColor = UIColor.purpleColor()
        graph.backgroundColor = Cores.appBackgroundColor

        let armazenamento_ocupado = AppDelegate.token.user!.armazenamentoOcupado! / 1000000
        
        let armazenamento = AppDelegate.token.user!.armazenamento! / 10000
        graph.maxValue = Float(armazenamento)
        graph.minValue = 0.0
        
        graph.setValue(Float(armazenamento_ocupado), animated: false)
        
        return graph
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
