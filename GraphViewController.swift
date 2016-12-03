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
   
    @IBOutlet weak var lblExecutando: UILabel!
    
    @IBOutlet weak var lblAgendado: UILabel!
    @IBOutlet weak var lblRestaurando: UILabel!
    @IBOutlet weak var lblRestaurado: UILabel!
    
    @IBOutlet weak var lblFalha: UILabel!
    
    
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
        self.ConfigLabels()
        self.configGraph()
        self.view.backgroundColor = Cores.appBackgroundColor
    }
    
    
    private func ConfigLabels()
    {
        let status = AppDelegate.token.user!.statusBackups!
        let total = (status.executado! + status.falha! + status.agendado! + status.executando! + status.restaurado! + status.restaurando!)
        
        lblExecutado.clipsToBounds =  true
        lblExecutado.layer.cornerRadius = 10
        lblExecutando.clipsToBounds =  true
        lblExecutando.layer.cornerRadius = 10
        lblAgendado.clipsToBounds =  true
        lblAgendado.layer.cornerRadius = 10
        lblFalha.clipsToBounds =  true
        lblFalha.layer.cornerRadius = 10
        lblRestaurado.clipsToBounds =  true
        lblRestaurado.layer.cornerRadius = 10
        lblRestaurando.clipsToBounds =  true
        lblRestaurando.layer.cornerRadius = 10
        
        lblExecutado.backgroundColor = Cores.executado
        lblExecutando.backgroundColor = Cores.executando
        lblAgendado.backgroundColor = Cores.agendado
        lblFalha.backgroundColor = Cores.falha
        lblRestaurado.backgroundColor = Cores.restaurado
        lblRestaurando.backgroundColor = Cores.restaurando
        
        
        lblExecutado.text = "10%"
        lblExecutando.text = "20%"
        lblAgendado.text = "30%"
        lblFalha.text = "15%"
        lblRestaurado.text = "5%"
        lblRestaurando.text = "20%"
        
    }
    
    private func configGraph()
    {
        let dictionarie = [
            [
                "name" : "Executado",
                "value" : AppDelegate.token.user!.statusBackups!.executado!,
                "color" : Cores.executado
            ],
            [
                "name" : "Falha",
                "value" : AppDelegate.token.user!.statusBackups!.falha!,
                "color" : Cores.falha
            ],
            [
                "name" : "Agendado",
                "value" : AppDelegate.token.user!.statusBackups!.agendado!,
                "color" : Cores.agendado
            ],
            [
                "name" : "Executando",
                "value" : AppDelegate.token.user!.statusBackups!.executando!,
                "color" : Cores.executando
            ],
            [
                "name" : "Restaurado",
                "value" : AppDelegate.token.user!.statusBackups!.restaurado!,
                "color" : Cores.restaurado
            ],
            [
                "name" : "Restaurando",
                "value" : AppDelegate.token.user!.statusBackups!.restaurando!,
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
