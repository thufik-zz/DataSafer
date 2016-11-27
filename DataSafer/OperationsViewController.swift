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


class OperationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var table: UITableView!
    var host : Host?
    var operations : NSMutableArray?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.table.registerNib(UINib(nibName: "OperationTableViewCell",bundle: nil), forCellReuseIdentifier: "operationCell")
        
        self.teste()

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
        
        cell.lblName.text = (self.operations![indexPath.row] as! Operation).nome!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let dictionary =
        [
            "data" : (operations![indexPath.row] as! Operation).ultimaOperacao!.data!,
            "status" : (operations![indexPath.row] as! Operation).ultimaOperacao!.status!,
            "tamanho" : (operations![indexPath.row] as! Operation).ultimaOperacao!.tamanho!
        
        ]
        
        let mensagem = "data = \(dictionary.valueForKey("data")!) \n status = \(dictionary.valueForKey("status")!) \n tamanho = \(dictionary.valueForKey("tamanho")!)"
        
        let alert = FCAlertView()
        alert.showAlertWithTitle("Informações", withSubtitle: mensagem , withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
    }
    

    func teste()
    {
        let url = NSMutableURLRequest(URL: NSURL(string: "http://senai.datasafer.com.br/gerenciamento/estacao/backups")!)
        
        let header =
    [
                "authorization" : AppDelegate.token.token,
                "content-type" : "application/json",
                "estacao" : host!.nome!
        ]
        
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: header).responseArray(completionHandler: { (response : Response<[Operation],NSError>) in
            
            //self.operations = NSMutableArray()
            
            if let op = response.result.value{
                self.operations = NSMutableArray(array: op)
                print(self.operations!)
            }
            else{
                print(response.debugDescription)
            }
            
            
            self.table.reloadData()
            
            
            
            
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
