//
//  YapilacakDetayViewModel.swift
//  YapilacaklarListesi
//
//  Created by Eren on 29.09.2024.
//

import Foundation


class YapilacakDetayViewModel {
    
    var yrepo = YapilacaklarRepository()
    
    func guncelle(id : Int, name : String) {
        yrepo.guncelle(id: id, name: name)
    }
    
}
