//
//  YapilacakKayit.swift
//  YapilacaklarListesi
//
//  Created by Eren on 22.09.2024.
//

import UIKit

class YapilacakKayit: UIViewController {
    
    @IBOutlet weak var tfYapilacakAd: UITextField!
    
    var viewModel = YapilacakKayitViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
  
        // Do any additional setup after loading the view.
    }
    

    @IBAction func buttonKaydet(_ sender: Any) {
        if let name = tfYapilacakAd.text {
            viewModel.kaydet(name: name)
        }
    }
    
    
}
