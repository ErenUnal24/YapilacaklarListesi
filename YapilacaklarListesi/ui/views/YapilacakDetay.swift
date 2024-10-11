//
//  YapilacakDetay.swift
//  YapilacaklarListesi
//
//  Created by Eren on 22.09.2024.
//

import UIKit

class YapilacakDetay: UIViewController {
    
    
    @IBOutlet weak var tfYapilacakAd: UITextField!
    
    var yapilacak : Yapilacaklar?
    
    var viewModel = YapilacakDetayViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let y = yapilacak {
            tfYapilacakAd.text = y.name
        }
   
        // Do any additional setup after loading the view.
    }
    

    @IBAction func buttonGuncelle(_ sender: Any) {
        if let y = yapilacak, let name = tfYapilacakAd.text{
            viewModel.guncelle(id: y.id!, name: name)
        }
    }
    
    
    

}
