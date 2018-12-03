

import Foundation
import UIKit
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrURL.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CastomTableViewCell
        cell.textView.isEditable = false
        let imageUrl:URL = URL(string: arrURL[indexPath.row].imageValueForTable)!
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            if let data = try? Data(contentsOf: imageUrl){
                DispatchQueue.main.async {
                    cell.myImageView.image = UIImage(data: data)
                    cell.myImageView.contentMode = .scaleAspectFit
                }
            }
        }
        cell.textView.text = arrURL[indexPath.row].textValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        nextVC.textFromVC = arrURL[indexPath.row].textValue
        nextVC.urlImage = arrURL[indexPath.row].imageValueForImage
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
}

extension ViewController :UITextFieldDelegate{
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}
