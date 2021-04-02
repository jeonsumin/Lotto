//
//  MainViewController.swift
//  Lotto
//
//  Created by Terry on 2021/03/28.
//

import UIKit
import AVFoundation
import QRCodeReader
import SafariServices

class MainViewController: UIViewController,QRCodeReaderViewControllerDelegate {
    
    var lotto = Array<[String:Any]>()
    
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var roundDate: UILabel!
    @IBOutlet weak var number1: UILabel!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var number3: UILabel!
    @IBOutlet weak var number4: UILabel!
    @IBOutlet weak var number5: UILabel!
    @IBOutlet weak var number6: UILabel!
    @IBOutlet weak var bonus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        /*
         LottoApi.shard
         .getLottoResult { (result) in
         self.lotto.append(contentsOf: result)
         }
         */
        fetchDate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK:- Private Methods
    private func fetchDate(){
        NSLog("lotto :: \(self.lotto)")
    }
    
    //MARK:- QRCcodeReader
  
    
    // QR코드 리더 뷰컨트롤러를 만든다
    // Good practice: create the reader lazily to avoid cpu overload during the
    // initialization and each time we need to scan a QRCode
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    
    //MARK:- IBAction methods
    @IBAction func didTappedResult(_ sender: Any) {
        let lastRoundVC = self.storyboard?.instantiateViewController(identifier: "LastRoundViewController") as! LastRoundViewController
        lastRoundVC.lotto = self.lotto
        self.navigationController?.pushViewController(lastRoundVC, animated: true)
        
    }
    
    @IBAction func didTappedQRCodeButton(_ sender: Any) {
        // Retrieve the QRCode content
        // By using the delegate pattern
        
        readerVC.delegate = self
        var scannedURL:String = ""
        // Or by using the closure pattern
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            print(result)
            guard let scanQRcodeUrlString = result?.value else { return }
            NSLog("scanQRcodeUrlString : \(scanQRcodeUrlString)")
            scannedURL = scanQRcodeUrlString
        }
        
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        
        //설정된 QR코드 뷰컨트롤러를 보여준다
        present(readerVC, animated: true, completion: nil)
        
        guard let url = URL(string: scannedURL) else { return }
        let safari = SFSafariViewController(url: url)
        safari.preferredBarTintColor = UIColor.white
        safari.preferredControlTintColor = UIColor.systemBlue
        self.present(safari,animated: true,completion: nil)
        
    }
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
}
