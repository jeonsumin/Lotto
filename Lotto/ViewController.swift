//
//  ViewController.swift
//  Lotto
//
//  Created by Terry on 2021/03/28.
//

import UIKit
import FMDB

class ViewController: UIViewController {
    
    var lottoNumbers = Array<Array<Int>>()
    var dataBasePath = String()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let fileMgr = FileManager.default
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0]
        dataBasePath = docsDir + "/lotto.db"
        if !fileMgr.fileExists(atPath: dataBasePath as String){
            let db = FMDatabase(path: dataBasePath as String )
            
            if db == nil {
                NSLog("DB 생성 오류")
            }
            
            if db.open() != false {
                let sql_statement = "create table if not exists lotto(id integer primary key autoincrement, number1 integer,number2 integer,number3 integer,number4 integer,number5 integer,number6 integer)"
                if !((db.executeStatements(sql_statement))) {
                    NSLog("테이블 생성 오류")
                }
            }else{
                NSLog("DB 연결 오류")
            }
        }
    }
    
}
extension ViewController {
    
    
    @IBAction func didTappeLoadData(_ sender: UIBarButtonItem) {
        lottoNumbers = Array<Array<Int>>()
        
        let db = FMDatabase(path: dataBasePath)
        
        if (db.open() != false ){
            do{
                let selectQuery = "select number1, number2, number3, number4, number5, number6 from lotto"
                let result: FMResultSet? = try db.executeQuery(selectQuery, values: nil)
                
                if result != nil {
                    while result!.next() {
                        var columnArray = Array<Int>()
                        columnArray.append(Int(result!.string(forColumn: "number1")!)!)
                        columnArray.append(Int(result!.string(forColumn: "number2")!)!)
                        columnArray.append(Int(result!.string(forColumn: "number3")!)!)
                        columnArray.append(Int(result!.string(forColumn: "number4")!)!)
                        columnArray.append(Int(result!.string(forColumn: "number5")!)!)
                        columnArray.append(Int(result!.string(forColumn: "number6")!)!)
                        
                        lottoNumbers.append(columnArray)
                    }
                    
                }else{
                    NSLog("자료 불러오기 실패")
                }
                table.reloadData()
            }catch(let error){
                NSLog("DB 연결 실패 \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func didTappedSave(_ sender: UIBarButtonItem) {
        let db = FMDatabase(path: dataBasePath)
        
        if (db.open() != false){
            do{
                try db.executeUpdate("delete from lotto", values: nil)
                
                if db.hadError() != false {
                    NSLog("DB 초기화 오류")
                }
                
                for numbers in lottoNumbers{
                    let insertQuery = "insert into lotto(number1, number2, number3, number4, number5, number6) values ( \(numbers[0]), \(numbers[1]),\(numbers[2]),\(numbers[3]),\(numbers[4]),\(numbers[5]))"
                    
                    try db.executeUpdate(insertQuery, values: nil)
                    if(db.hadError() != false){
                        NSLog("저장 오류")
                    }else{
                        NSLog("저장성공")
                    }
                }
            }catch (let error ){
                NSLog("\(error.localizedDescription)")
            }
        }else{
            NSLog("DB연결 오류")
        }
    }
    
    @IBAction func didTappedDraw(_ sender: UIBarButtonItem) {
        
        lottoNumbers = Array<Array<Int>>()
        
        var originalNumbers = Array(1...45)
        
        var index = 0
        
        for _ in 0...4 {
            originalNumbers = Array(1...45)
            var columnArray = Array<Int>()
            
            for _ in 0...5 {
                index = Int(arc4random_uniform(UInt32(originalNumbers.count)))
                columnArray.append(originalNumbers[index])
                originalNumbers.remove(at: index)
            }
            columnArray.sort(by: {$0 < $1 })
            lottoNumbers.append(columnArray)
        }
        table.reloadData()
    }
}
//MARK: - TableViewDataSource
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lottoNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LottoCell
        
        let row = indexPath.row
        
        cell.LottoNum1.text = "\(lottoNumbers[row][0])"
        cell.LottoNum2.text = "\(lottoNumbers[row][1])"
        cell.LottoNum3.text = "\(lottoNumbers[row][2])"
        cell.LottoNum4.text = "\(lottoNumbers[row][3])"
        cell.LottoNum5.text = "\(lottoNumbers[row][4])"
        cell.LottoNum6.text = "\(lottoNumbers[row][5])"
        
        return cell
        
    }
}
//MARK: - TableViewDelegate
extension ViewController: UITableViewDelegate{
    
}

