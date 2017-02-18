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
import FCAlertView



class BackupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var hostsArray: [Host]?
    
    
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        if self.hostsArray == nil{
            return 0
        }
        else{
            return self.hostsArray!.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("hostCell") as! HostTableViewCell
        
        if (((hostsArray![indexPath.row].nome)!.containsString("Estacao")))
        {
            cell.computerImage.image = UIImage.init(named: "computer")
        }
        else if (((hostsArray![indexPath.row].nome)!.containsString("Laptop")))
        {
            cell.computerImage.image = UIImage.init(named: "laptop")
        }
        else if (((hostsArray![indexPath.row].nome)!.containsString("Computador")))
        {
            cell.computerImage.image = UIImage.init(named: "workstation")
        }
        
        cell.selectionStyle = .None
        cell.hostName.text = (hostsArray![indexPath.row] ).nome
        cell.backgroundColor = Cores.appBackgroundColor
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let operationsViewController = storyboard?.instantiateViewControllerWithIdentifier("operationsViewController") as! OperationsViewController
        operationsViewController.host = hostsArray![indexPath.row]
        operationsViewController.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(operationsViewController, animated: true)
        
    }
    
    private func configView(){
        self.table.registerNib(UINib(nibName: "HostTableViewCell",bundle: nil), forCellReuseIdentifier: "hostCell")
        self.table.backgroundColor = Cores.appBackgroundColor
        self.loadHosts()
    }
    

    private func loadHosts(){
        
        let loading = ALLoadingView()
        let alert = FCAlertView()
    
        loading.showLoadingViewOfType(.Default, windowMode: .Fullscreen)
        
        
        Request.getHosts({ (response) -> Void in

            loading.hideLoadingView({
                
                self.hostsArray = response as? [Host]
                self.table.reloadData()
            })
            }, failure: {(error) -> Void in
                
                loading.hideLoadingView({
                    
                    alert.makeAlertTypeCaution()
                    alert.showAlertWithTitle("Atenção", withSubtitle: "Erro ao carregar os hosts", withCustomImage: nil, withDoneButtonTitle: "Ok", andButtons: nil)
            })
                
        })
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
