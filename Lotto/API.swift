//
//  API.swift
//  Lotto
//
//  Created by Terry on 2021/03/31.
//

import UIKit
typealias lotto = Array<[String:Any]>
class LottoApi {
    static let shard = LottoApi()
    
    func getLottoResult(completion:@escaping (lotto) -> Void) {
        
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=955"
            let session = URLSession.shared
            guard let requestUrl = URL(string: url) else { return }
            session.dataTask(with: requestUrl){ data, response, error in
                var lottoResult = Array<[String:Any]>()
                guard error == nil else {
                    NSLog("\(String(describing: error?.localizedDescription))")
                    return
                }
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    lottoResult.append(jsonData as! [String : Any])
                    completion(lottoResult)
                }catch(let error ) {
                    NSLog("\(String(error.localizedDescription))")
                }
            }.resume()
        }
            
    
}
