

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var idInputTextField: UITextField!
    @IBOutlet weak var tableViewForJson: UITableView!
    var x = String()//url foto
    var arrURL = [VkJson]()
    let identifier = "myCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    

    @IBAction func testButton(_ sender: UIButton) {
        var inputID = ""
        inputID = idInputTextField.text ?? ""
        arrURL.removeAll()
        
        let url:String = "https://api.vk.com/method/wall.get?owner_id=\(inputID)&access_token=459b5a0df6b726e0d75fd2c76a991ca915337efa4668a82a1f1a16e3e8449a2627b59f14af61440f4f9ca&v=5.87"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print(json)
                for i in 0  ... (json["response"]["items"].count-1){
                    var textValue = ""
                    self.x = ((json["response"]["items"][11]["attachments"][0]["photo"]["sizes"].array?.first!["url"].stringValue) ?? (json["response"]["items"][i]["copy_history"][0]["attachments"][0]["photo"]["sizes"].array?.first!["url"].stringValue) ?? ("https://cdn.pixabay.com/photo/2012/05/07/02/49/pirate-47705_1280.png"))
                    textValue = (json["response"]["items"][i]["copy_history"][0]["text"]).stringValue
                    let valueForArr = VkJson()
                    valueForArr.imageValue = self.x
                    valueForArr.textValue = textValue
                    self.arrURL.append(valueForArr)
                }
                self.tableViewForJson.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
        
        
    }
    @IBAction func startButton(_ sender: UIButton) {
        var inputID = ""
        inputID = idInputTextField.text ?? ""
        let url:String = "https://api.vk.com/method/wall.get?owner_id=-\(inputID)&access_token=459b5a0df6b726e0d75fd2c76a991ca915337efa4668a82a1f1a16e3e8449a2627b59f14af61440f4f9ca&v=5.87"

        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                for i in 0  ... (json["response"]["items"].count-1){
                    var textValue = ""
                    self.x = (json["response"]["items"][i]["attachments"][0]["photo"]["sizes"].array?.first!["url"].stringValue) ?? ("https://cdn.pixabay.com/photo/2012/05/07/02/49/pirate-47705_1280.png")
                    textValue = (json["response"]["items"][i]["text"]).stringValue
                    let valueForArr = VkJson()
                    valueForArr.imageValue = self.x
                    valueForArr.textValue = textValue
                    self.arrURL.append(valueForArr)
                }
                self.tableViewForJson.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    

    
}
extension ViewController : UITableViewDragDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return []
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrURL.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CastomTableViewCell
        let imageUrl:URL = URL(string: arrURL[indexPath.row].imageValue)!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageUrl){
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: data)
                }
            }else{cell.myImageView.image = UIImage(named: "1480622087_rodzher-s-sigaroy.png")}
        }
        cell.textView.text = arrURL[indexPath.row].textValue
        return cell
    }
    
    
}
