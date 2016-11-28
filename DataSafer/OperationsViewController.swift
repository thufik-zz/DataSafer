//
//  OperationsViewController.swift
//  DataSafer
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 26/11/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import Alamofire
import FCAlertView
import ALLoadingView


class OperationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var table: UITableView!
    var host : Host?
    var operations : [Operation]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.configView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let op = operations{
            return op.count
        }
        else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.table.dequeueReusableCellWithIdentifier("operationCell") as! OperationTableViewCell
        
        cell.lblName.text = (self.operations![indexPath.row]).nome!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.showAlert(operations![indexPath.row])
        
    }
    
    private func showAlert(operation : Operation){
        
        let dictionary =
            [
                "data" : operation.ultimaOperacao!.data!,
                "status" : operation.ultimaOperacao!.status!,
                "tamanho" : operation.ultimaOperacao!.tamanho!
                
        ]
        
        let mensagem = "data = \(dictionary.valueForKey("data")!) \n status = \(dictionary.valueForKey("status")!) \n tamanho = \(dictionary.valueForKey("tamanho")!)"
        
        let alert = FCAlertView()
        alert.showAlertWithTitle("Informações", withSubtitle: mensagem , withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
    }
    
    func configView(){
        self.table.registerNib(UINib(nibName: "OperationTableViewCell",bundle: nil), forCellReuseIdentifier: "operationCell")
        self.view.backgroundColor = Cores.appBackgroundColor
        self.loadBackups()
    }
    
    func loadBackups(){
    
        let loading = ALLoadingView()
        let alert = FCAlertView()
        loading.showLoadingViewOfType(.Default, windowMode: .Fullscreen)
        
        Request.getBackups(self.host!, success: { (response) -> Void in
            
            loading.hideLoadingView({
            
                self.operations = response as? [Operation]
                self.table.reloadData()
            
            })
            }, failure: { (error) -> Void in
        
                loading.hideLoadingView({
                
                    alert.makeAlertTypeCaution()
                    alert.showAlertWithTitle("Atenção", withSubtitle: "Erro ao carregar as operações", withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
            })
        })
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
