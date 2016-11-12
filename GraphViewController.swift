//
//  GraphViewController.swift
//  DataSafer
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 10/1/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import VBPieChart

class GraphViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let dictionarie = [
            [
                "name" : "Sucesso",
                "value" : 200,
                "color" : UIColor.darkGrayColor()//UIColor.init(red: 0, green: 255, blue: 127, alpha: 1.0)
                //"strokeColor" : UIColor.init(red: 2550.0, green: 255.0, blue: 255.0, alpha: 1.0)
            ],
            [
                "name" : "Falha",
                "value" : 70,
                "color" : UIColor.blueColor()//UIColor.init(red: 255, green: 48, blue: 48, alpha: 1.0)
            ],
            [
                "name" : "Agendado",
                "value" : 50,
                "color" : UIColor.brownColor()//UIColor.init(red: 30, green: 144, blue: 255, alpha: 1.0)
            ],
            [
                "name" : "Executando",
                "value" : 100,
                "color" : UIColor.cyanColor()//UIColor.init(red: 30, green: 144, blue: 255, alpha: 1.0)
            ],
            [
                "name" : "Excluído",
                "value" : 30,
                "color" : UIColor.greenColor()//UIColor.init(red: 34, green: 139, blue: 34, alpha: 1.0)
            ]
        ]
 
    
        
        let vbpiechart = VBPieChart(frame: CGRect(x: 30, y: 100, width: 250, height: 250))
        
        
        
        
        self.view.addSubview(vbpiechart)
        
        //vbpiechart.enableStrokeColor = true;
        vbpiechart.holeRadiusPrecent = 0.3
        ///vbpiechart.seten
        
        //vbpiechart.setChartValues(dictionarie, animation: true,options: .growthBack)
        
        vbpiechart.setChartValues(dictionarie, animation: true)
        
        
        //VBPieChart.setAnimationsEnabled(true)
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
