//
//  MainViewController.swift
//  Lotto
//
//  Created by Terry on 2021/03/28.
//

import UIKit

class MainViewController: UIViewController {
    
    var lotto = Array<[String:Any]>()
    
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var number1: UILabel!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var number3: UILabel!
    @IBOutlet weak var number4: UILabel!
    @IBOutlet weak var number5: UILabel!
    @IBOutlet weak var number6: UILabel!
    @IBOutlet weak var bonus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 950...956{
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(i)"
            let session = URLSession.shared
            guard let requestUrl = URL(string: url) else { return }
            session.dataTask(with: requestUrl){ data, response, error in
                guard error == nil else {
                    NSLog("\(String(describing: error?.localizedDescription))")
                    return
                }
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                    self.lotto = jsonData as! Array<[String : Any]>
                    self.lotto.append(jsonData as! [String : Any])
                    
                }catch(let error ) {
                    NSLog("\(String(error.localizedDescription))")
                }
            }.resume()
        }
            
        lastRoundResult()
    }
    
    @IBAction func didTappedResult(_ sender: Any) {
        let lastRoundVC = self.storyboard?.instantiateViewController(identifier: "LastRoundViewController") as! LastRoundViewController
        lastRoundVC.lotto = self.lotto
        self.navigationController?.pushViewController(lastRoundVC, animated: true)
        
    }
    
    private func lastRoundResult(){
        NSLog("lotto :: \(self.lotto)")
    }

}
