

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var idInputTextField: UITextField!
    @IBOutlet weak var tableViewForJson: UITableView!
    var arrURL = [VkJson]()
    let identifier = "myCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        idInputTextField.delegate = self
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
                print(json)
                for i in 0  ... json["response"]["items"].count-1{
                    var textValue = String()
                    var urlImageValue = String()
                    var urlImageForImage = String()
                    
                    urlImageValue = ((json["response"]["items"][i]["attachments"][0]["photo"]["sizes"].array?.first!["url"].stringValue) ?? (json["response"]["items"][i]["copy_history"][0]["attachments"][0]["photo"]["sizes"].array?.first!["url"].stringValue) ?? ("https://www.komus.ru/medias/sys_master/root/h03/h04/9137795203102.jpg"))
                    
                    urlImageForImage = (((json["response"]["items"][i]["attachments"][0]["photo"]["sizes"].array?.last!["url"].stringValue)) ?? (json["response"]["items"][i]["copy_history"][0]["attachments"][0]["photo"]["sizes"].array?.last!["url"].stringValue) ?? ("https://www.komus.ru/medias/sys_master/root/h03/h04/9137795203102.jpg"))
                    
                    textValue = (json["response"]["items"][i]["text"]).stringValue
                    if textValue == "" {
                        textValue = (json["response"]["items"][i]["copy_history"][0]["text"]).stringValue
                    }
                    let valueForArr = VkJson()
                    valueForArr.imageValueForTable = urlImageValue
                    valueForArr.imageValueForImage = urlImageForImage
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
                //print(json)
                for i in 0  ... (json["response"]["items"].count-1){
                    var textValue = String()
                    var urlImageValue = String()
                    var urlImageForImage = String()
                    
                    urlImageValue = (json["response"]["items"][i]["attachments"][0]["photo"]["sizes"].array?.first!["url"].stringValue) ?? (json["response"]["items"][i]["attachments"][0]["link"]["photo"]["sizes"].array?.first!["url"].stringValue) ?? ("https://www.komus.ru/medias/sys_master/root/h03/h04/9137795203102.jpg")
                    
                    urlImageForImage = (json["response"]["items"][i]["attachments"][0]["photo"]["sizes"].array?.last!["url"].stringValue) ?? (json["response"]["items"][i]["attachments"][0]["link"]["photo"]["sizes"].array?.last!["url"].stringValue) ?? ("https://www.komus.ru/medias/sys_master/root/h03/h04/9137795203102.jpg")
                    
                    textValue = (json["response"]["items"][i]["text"]).stringValue
                    let valueForArr = VkJson()
                    valueForArr.imageValueForTable = urlImageValue
                    valueForArr.imageValueForImage = urlImageForImage
                    valueForArr.textValue = textValue
                    self.arrURL.append(valueForArr)
                }
                self.tableViewForJson.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.idInputTextField.resignFirstResponder()
    }
}
