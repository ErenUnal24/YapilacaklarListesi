//
//  YapilacaklarRepository.swift
//  YapilacaklarListesi
//
//  Created by Eren on 29.09.2024.
//

import Foundation
import RxSwift

class YapilacaklarRepository {
    
    var yapilacaklarListesi = BehaviorSubject<[Yapilacaklar]>(value: [Yapilacaklar]())
    let db:FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("todolist.db")  // ********************** dosya ismi yanlış ***********************
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func kaydet(name:String) {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO tasks (name) VALUES (?)", values: [name])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func guncelle(id : Int, name : String) {
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE tasks SET name = ? WHERE id = ?", values: [name,id])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func yapilacakSil(id:Int) {
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE FROM tasks WHERE id = ?", values: [id])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    func ara(aramaKelimesi:String) {
        db?.open()
        
        do {
            var liste = [Yapilacaklar]()
            
            let rs = try db!.executeQuery("SELECT * FROM tasks WHERE name like '%\(aramaKelimesi)%'", values: nil)
                                                                                    
            while rs.next() {
                let id = Int(rs.string(forColumn: "id"))
                let name = rs.string(forColumn: "name")
                
                let yapilacak = Yapilacaklar(id: id!, name: name!)
                liste.append(yapilacak)
            }
            
            yapilacaklarListesi.onNext(liste)
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func yapilacaklariYukle() {
        
        db?.open()
        
        do {
            var liste = [Yapilacaklar]()
            
            let rs = try db!.executeQuery("SELECT * FROM tasks", values: nil)
            
            while rs.next() {
                let id = Int(rs.string(forColumn: "id"))
                let name = rs.string(forColumn: "name")
                
                let yapilacak = Yapilacaklar(id: id!, name: name!)
                liste.append(yapilacak)
            }
            
            yapilacaklarListesi.onNext(liste) // Tetikleme
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
}

