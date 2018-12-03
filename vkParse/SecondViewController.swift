

import UIKit

class SecondViewController: UIViewController {
    var urlImage = String()
    var textFromVC = String()
    @IBOutlet weak var imageDtail: UIImageView!
    @IBOutlet weak var textDetail: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(urlImage)
        self.textDetail.text = textFromVC
        let urlImg:URL = URL(string: urlImage)!
        let queue = DispatchQueue.global(qos:.userInteractive)
        queue.async {
            if let data = try? Data(contentsOf: urlImg){
                DispatchQueue.main.async {
                    self.imageDtail.image = UIImage(data: data)
                    self.imageDtail.contentMode = .scaleAspectFit
                }
            }
        }
    }
}
