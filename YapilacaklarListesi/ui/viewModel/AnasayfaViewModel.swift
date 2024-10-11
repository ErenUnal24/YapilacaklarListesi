//
//  AnasayfaViewModel.swift
//  YapilacaklarListesi
//
//  Created by Eren on 29.09.2024.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    
    var krepo = YapilacaklarRepository()
    var yapilacaklarListesi = BehaviorSubject<[Yapilacaklar]>(value: [Yapilacaklar]())

    init() {
        veritabaniKopyala()
        yapilacaklariYukle()
        yapilacaklarListesi = krepo.yapilacaklarListesi
    }
    
    func yapilacakSil(id:Int) {
        krepo.yapilacakSil(id: id)
        yapilacaklariYukle()
    }
    func ara(aramaKelimesi:String) {
        krepo.ara(aramaKelimesi: aramaKelimesi)
    }
    func yapilacaklariYukle() {
        krepo.yapilacaklariYukle()
    }
    
    func veritabaniKopyala(){
            let bundleYolu = Bundle.main.path(forResource: "todolist", ofType: ".db")   // **************** dosya ismi değişecek *****************
            let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("todolist.db") // **************** dosya ismi değişecek *****************
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: kopyalanacakYer.path){
                print("Veritabanı zaten var")
            }else{
                do{
                    try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                }catch{}
            }
        }
    
}
