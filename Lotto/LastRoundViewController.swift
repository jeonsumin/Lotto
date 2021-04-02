//
//  LastRoundViewController.swift
//  Lotto
//
//  Created by Terry on 2021/03/28.
//

import UIKit

class LastRoundViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    var lotto = Array<[String:Any]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "회차별 당첨 결과"
        table.delegate = self
        table.dataSource = self
        self.navigationController?.navigationBar.isHidden = false
        
        // Do any additional setup after loading the view.
    }
}
extension LastRoundViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lotto.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LastRoundCell
        
        cell.roundDate.text = lotto[indexPath.row]["drwNoDate"]! as? String
        cell.round.text = "\(lotto[indexPath.row]["drwNo"]!)회"
        cell.number1.text = "\(lotto[indexPath.row]["drwtNo1"]!)"
        cell.number2.text = "\(lotto[indexPath.row]["drwtNo2"]!)"
        cell.number3.text = "\(lotto[indexPath.row]["drwtNo3"]!)"
        cell.number4.text = "\(lotto[indexPath.row]["drwtNo4"]!)"
        cell.number5.text = "\(lotto[indexPath.row]["drwtNo5"]!)"
        cell.number6.text = "\(lotto[indexPath.row]["drwtNo6"]!)"
        cell.bonus.text = "\(lotto[indexPath.row]["bnusNo"]!)"
        cell.amount.text = "1등 당첨 금액  \(lotto[indexPath.row]["firstAccumamnt"]!)원"
        
        return cell
    }
    
}
class LastRoundCell:UITableViewCell {
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var roundDate: UILabel!
    @IBOutlet weak var number1: UILabel!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var number3: UILabel!
    @IBOutlet weak var number4: UILabel!
    @IBOutlet weak var number5: UILabel!
    @IBOutlet weak var number6: UILabel!
    @IBOutlet weak var bonus: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    @IBOutlet weak var bg1: UIImageView!
    @IBOutlet weak var bg2: UIImageView!
    @IBOutlet weak var bg3: UIImageView!
    @IBOutlet weak var bg4: UIImageView!
    @IBOutlet weak var bg5: UIImageView!
    @IBOutlet weak var bg6: UIImageView!
    @IBOutlet weak var bg7: UIImageView!
    
}

extension LastRoundViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
