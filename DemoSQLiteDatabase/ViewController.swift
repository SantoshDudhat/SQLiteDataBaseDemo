//
//  ViewController.swift
//  DemoSQLiteDatabase
//
//  Created by DREAMWORLD on 22/11/24.
//

import UIKit
import Alamofire
import SDWebImage

enum SelectedOption {
    case home
    case favourites
}

class ViewController: UIViewController {

    @IBOutlet weak var tblUserList: UITableView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    
    let cellReuseIdentifier = "CellAnime"
    
    var db: DBHelper = DBHelper()
    
    var arrAnimeList = [Datum]()
    var nextPage = 1
    var isAPICalling = false
    var isLoaded = false
    var selectedOption: SelectedOption = .home
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblUserList.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        tblUserList.delegate = self
        tblUserList.dataSource = self
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        getAnimeDataList(page: 1)
    }
    
    @objc func btnFavouriteClk(_ sender: UIButton) {
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: self.tblUserList)
        guard let indexPath = self.tblUserList.indexPathForRow(at: buttonPosition) else {return}
        sender.isSelected = !sender.isSelected
        var objAnime = selectedOption == .home ? isSearching ? arrAnimeList.filter({ $0.title?.contains(txtSearch.text ?? "") ?? false })[indexPath.row] : self.arrAnimeList[indexPath.row] : isSearching ? arrAnimeList.filter({ $0.title?.contains(txtSearch.text ?? "") ?? false && $0.isFavourited })[indexPath.row] : arrAnimeList.filter({ $0.isFavourited })[indexPath.row]
        if sender.isSelected {
            db.insert(id: objAnime.malid ?? 0)
        } else {
            db.deleteByID(id: objAnime.malid ?? 0)
        }
        objAnime.isFavourited = sender.isSelected
        if selectedOption == .home {
            if isSearching {
                if let firstIndex = self.arrAnimeList.firstIndex(where: { $0.malid == objAnime.malid }) {
                    arrAnimeList[firstIndex] = objAnime
                }
            } else {
                self.arrAnimeList[indexPath.row] = objAnime
            }
        } else {
            if let firstIndex = self.arrAnimeList.firstIndex(where: { $0.malid == objAnime.malid }) {
                arrAnimeList[firstIndex] = objAnime
            }
        }
        self.tblUserList.reloadData()
    }
    
    @IBAction func btnHomeClk(_ sender: UIButton) {
        if selectedOption != .home {
            selectedOption = .home
            self.tblUserList.reloadData()
        }
    }
    
    @IBAction func btnAllFavouritesClk(_ sender: UIButton) {
        if selectedOption != .favourites {
            selectedOption = .favourites
            self.tblUserList.reloadData()
        }
    }
}

//MARK: - TableView Delegate and Datasource methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedOption == .home ? isSearching ? arrAnimeList.filter({ $0.title?.contains(txtSearch.text ?? "") ?? false }).count : arrAnimeList.count : isSearching ? arrAnimeList.filter({ $0.title?.contains(txtSearch.text ?? "") ?? false && $0.isFavourited }).count : arrAnimeList.filter({ $0.isFavourited }).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! CellAnime
        let objAnime = selectedOption == .home ? isSearching ? arrAnimeList.filter({ $0.title?.contains(txtSearch.text ?? "") ?? false })[indexPath.row] : self.arrAnimeList[indexPath.row] : isSearching ? arrAnimeList.filter({ $0.title?.contains(txtSearch.text ?? "") ?? false && $0.isFavourited })[indexPath.row] : arrAnimeList.filter({ $0.isFavourited })[indexPath.row]
        cell.imgVw.sd_setImage(with: URL(string: objAnime.images?.jpg?.imageurl ?? ""))
        cell.lblName.text = objAnime.title
        cell.lblDesc.text = objAnime.synopsis
        cell.btnFavourite.isSelected = objAnime.isFavourited
        cell.btnFavourite.addTarget(self, action: #selector(btnFavouriteClk), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == arrAnimeList.count - 5, !isAPICalling, !isLoaded, nextPage <= 10 {
            self.getAnimeDataList(page: nextPage)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - Get Anime Data API Call
extension ViewController {
    func getAnimeDataList(page: Int) {
        let url = "https://api.jikan.moe/v4/anime?page=\(page)"
        self.isAPICalling = true
        AF.request(url, method: .get).responseDecodable(of: GetAnimeListResponse.self) { results in
            self.isAPICalling = false
            switch results.result {
            case .success(let getAnimeResponse):
                if let animes = getAnimeResponse.data {
                    self.nextPage += 1
                    for anime in animes {
                        self.arrAnimeList.append(anime)
                    }
                } else {
                    self.isLoaded = true
                }
                
                let arrAnime = self.db.read()
                for anime in arrAnime {
                    if let firstIndex = self.arrAnimeList.firstIndex(where: { $0.malid == anime.malid }) {
                        self.arrAnimeList[firstIndex].isFavourited = true
                    }
                }

                print(getAnimeResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.tblUserList.reloadData()
        }
    }
}

//MARK: - Handle Search Field
extension ViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        isSearching = txtSearch.text != ""
        self.tblUserList.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearch.resignFirstResponder()
        return true
    }
}
