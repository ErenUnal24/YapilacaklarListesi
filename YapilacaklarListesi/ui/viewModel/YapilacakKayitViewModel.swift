//
//  YapilacakKayitViewModel.swift
//  YapilacaklarListesi
//
//  Created by Eren on 29.09.2024.
//

import Foundation

class YapilacakKayitViewModel {
    
    var yrepo = YapilacaklarRepository()
    
    func kaydet(name:String) {
        yrepo.kaydet(name: name)
    }
    
}
