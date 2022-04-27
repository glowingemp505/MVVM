

import UIKit
import Alamofire
import SwiftUI

class HomeVC: UIViewController {

    var homeModel = ViewModel()
    
    @IBOutlet weak var tbv :UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeModel.vc = self
        homeModel.gethomeVCdata()
     
    }
    
    
}
extension HomeVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeModel.arrUsers.count
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTVC
            cell.name.text = self.homeModel.arrUsers[indexPath.row].type
            cell.source.text = self.homeModel.arrUsers[indexPath.row].source
            cell.id.text = self.homeModel.arrUsers[indexPath.row].id
            cell.updated.text = self.homeModel.arrUsers[indexPath.row].updatedAt
        return cell
    }
    
    
    

}
