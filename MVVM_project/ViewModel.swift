
import UIKit
import Alamofire

class ViewModel{
    
    weak var vc : HomeVC?
    var arrUsers = [Model]()
    
    func gethomeVCdata() {

        ALF.shared.doGetData(parameters: [:], method: "facts/") { response in
            print(response)

            if let data = response as? [[String:Any]] {
                for item in data {
                    self.arrUsers.append(Model (fromDictionary: item))
                }
                DispatchQueue.main.async {
                    self.vc?.tbv.reloadData()
                }

                
            }
        } fail: { response in
            print(response)
        }

    }
  
}
