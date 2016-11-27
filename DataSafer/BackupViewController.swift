//
//  BackupViewController.swift
//  
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 9/10/16.
//
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ALLoadingView



class BackupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var hostsArray: NSMutableArray?
    
    var load = false;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.table.registerNib(UINib(nibName: "HostTableViewCell",bundle: nil), forCellReuseIdentifier: "hostCell")
        
        
        let url = NSMutableURLRequest(URL: NSURL(string: "http://senai.datasafer.com.br/gerenciamento/usuario/estacoes")!)
        
        
        let header = ["Authorization" : AppDelegate.token.token, "content-type" : "application/json"]
        
        let loadingview = ALLoadingView()
        loadingview.showLoadingViewOfType(.Default, windowMode: .Fullscreen)
        
        
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: header).responseArray(completionHandler: { (response: Response<[Host],NSError>) in
        
            
            
            self.hostsArray = NSMutableArray()
            
            if let hosts = response.result.value
            {
                for host in hosts
                {
                    self.hostsArray?.addObject(host)
                }
            }
            
            loadingview.hideLoadingView()
            self.load = true
            self.table.reloadData()
        
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !load
        {
            return 0
        }
        else
        {
            return (hostsArray?.count)!
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("hostCell") as! HostTableViewCell
        
        cell.hostName.text = (hostsArray![indexPath.row] as! Host).nome
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let operationsViewController = storyboard?.instantiateViewControllerWithIdentifier("operationsViewController") as! OperationsViewController
        operationsViewController.host = hostsArray![indexPath.row] as? Host
        operationsViewController.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(operationsViewController, animated: true)
        
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
