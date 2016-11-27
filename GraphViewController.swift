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

    
    @IBOutlet weak var lblExecutado: UILabel!
    @IBOutlet weak var lblFalha: UILabel!
    @IBOutlet weak var lblAgendado: UILabel!
    @IBOutlet weak var lblExecutando: UILabel!
    @IBOutlet weak var lblRestaurando: UILabel!
    @IBOutlet weak var lblRestaurado: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        self.ConfigLabels()
        self.configGraph()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ConfigLabels()
    {
        lblExecutado.backgroundColor = Cores.executado
        lblExecutando.backgroundColor = Cores.executando
        lblAgendado.backgroundColor = Cores.agendado
        lblFalha.backgroundColor = Cores.falha
        lblRestaurado.backgroundColor = Cores.restaurado
        lblRestaurando.backgroundColor = Cores.restaurando
    }
    
    func configGraph()
    {
        let dictionarie = [
            [
                "name" : "Executado",
                "value" : 200,
                "color" : Cores.executado
            ],
            [
                "name" : "Falha",
                "value" : 70,
                "color" : Cores.falha
            ],
            [
                "name" : "Agendado",
                "value" : 50,
                "color" : Cores.agendado
            ],
            [
                "name" : "Executando",
                "value" : 100,
                "color" : Cores.executando
            ],
            [
                "name" : "Restaurado",
                "value" : 30,
                "color" : Cores.restaurado
            ],
            [
                "name" : "Restaurando",
                "value" : 30,
                "color" : Cores.restaurando
            ]
        ]
        
        let vbpiechart = VBPieChart(frame: CGRect(x: 30, y: 100, width: 250, height: 250))
        vbpiechart.holeRadiusPrecent = 0.3
        vbpiechart.setChartValues(dictionarie, animation: false)
        self.view.addSubview(vbpiechart)
        
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
