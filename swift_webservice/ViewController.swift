//
//  ViewController.swift
//  swift_webservice
//
//  Created by shin seunghyun on 2020/04/19.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import AlamofireImage
import PromiseKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var dataSourceArr = [Actor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 180
        let apiCall = APIManager.shared.fetchActorsFromApi()
        let _ = apiCall.done { (actors) in
            self.dataSourceArr = actors
            self.tableView.reloadData()
        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCell") as! ActorCell
        cell.name.text = dataSourceArr[indexPath.row].name!
        cell.country.text = dataSourceArr[indexPath.row].country!
        cell.spouse.text = dataSourceArr[indexPath.row].spouse!
        cell.actorImage.af.setImage(withURL: URL(string: dataSourceArr[indexPath.row].imageUrl!)!)
        cell.descLabel.text = dataSourceArr[indexPath.row].des!
        
        return cell
    }


}

//App Transpoprt Security Settings
//Allow Arbitrrary Loads, => Yes

