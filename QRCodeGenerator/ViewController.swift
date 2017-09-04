//
//  ViewController.swift
//  QRCodeGenerator
//
//  Created by Xiaolong Zhang on 9/3/17.
//  Copyright © 2017 Xiaolong Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageQRCode: UIImageView!
    @IBOutlet weak var generateButton: UIButton!
    
    var qrCodeImage: CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func performButtonAction(_ sender: Any) {
        if qrCodeImage == nil {
            guard let userEnteredText = textField.text, !userEnteredText.isEmpty else {
                return
            }
            displayQRCodeImage(withText: userEnteredText)
            generateButton.setTitle("Clear", for: .normal)
        } else {
            imageQRCode.image = nil
            qrCodeImage = nil
            generateButton.setTitle("Generate", for: .normal)
        }
    }
    
    func displayQRCodeImage(withText userEnteredText: String) {

        let data = userEnteredText.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        qrCodeImage = filter?.outputImage
        
        let scaleX = imageQRCode.frame.size.width / qrCodeImage.extent.size.width
        let scaleY = imageQRCode.frame.size.height / qrCodeImage.extent.size.height
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        qrCodeImage = filter?.outputImage?.transformed(by: transform)
        
        if let qrImage = qrCodeImage {
            imageQRCode.image = UIImage(ciImage: qrImage)
            textField.resignFirstResponder()
        }
    }
    
}

