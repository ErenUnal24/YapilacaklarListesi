//
//  ViewController.swift
//  YapilacaklarListesi
//
//  Created by Eren on 22.09.2024.
//

import UIKit

class Anasayfa: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var yapilacaklarTableView: UITableView!
    
    var yapilacaklarListesi = [Yapilacaklar]()
    
    var viewModel = AnasayfaViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        yapilacaklarTableView.delegate = self
        yapilacaklarTableView.dataSource = self
        
        _ = viewModel.yapilacaklarListesi.subscribe(onNext: { liste in
            self.yapilacaklarListesi = liste
            self.yapilacaklarTableView.reloadData()
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.yapilacaklariYukle()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detayGecis" {
            if let yapilacak = sender as? Yapilacaklar {
                let gidilecekVC = segue.destination as! YapilacakDetay
                gidilecekVC.yapilacak = yapilacak
            }
        }
    }
    
    
}

extension Anasayfa: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.ara(aramaKelimesi: searchText)
    }
    
}

extension Anasayfa: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yapilacaklarListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let hucre = tableView.dequeueReusableCell(withIdentifier: "yapilacaklarHucre") as! YapilacaklarHucre
        
        let yapilacak = yapilacaklarListesi[indexPath.row]
        
        hucre.labelYapilacakAd.text = yapilacak.name
        
        return hucre
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let yapilacak = yapilacaklarListesi[indexPath.row]
        performSegue(withIdentifier: "detayGecis", sender: yapilacak)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: UIContextualAction.Style.destructive, title: "Sil") { contexualAction, view, bool in
            let yapilacak = self.yapilacaklarListesi[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "Kişi Sil: \(yapilacak.id!)", preferredStyle: UIAlertController.Style.alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                self.viewModel.yapilacakSil(id: yapilacak.id!)
            }
            alert.addAction(evetAction)
            
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
            
    }
    
}

