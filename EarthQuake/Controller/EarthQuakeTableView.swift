//
//  EarthQuakeTableView.swift
//  EarthQuake
//
//  Created by Son on 11/19/18.
//  Copyright © 2018 NguyenHoangSon. All rights reserved.
//

import UIKit

class EarthQuakeTableView: UITableViewController, UISearchResultsUpdating {
    
    let searchbar = UISearchController(searchResultsController: nil)
    var arrEarthQuake: [EarthQuake] = []
    var filterEarthQuake: [EarthQuake] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "EarthQuake"
        tableView.rowHeight = 90
        //Bằng việc gán protocol searchResultsUpdater, chúng ta có thể xác định mỗi khi ô text trong search bar được thay đổi.
        searchbar.searchResultsUpdater = self
        // set là false để trong quá trình search, tableView của chúng ta không bị che khuất
        searchbar.dimsBackgroundDuringPresentation = false
        // Ẩn/ hiện Navigation khi nút search active
        searchbar.hidesNavigationBarDuringPresentation = false
        // true để search bar của chúng ta không bị lỗi layout khi sử dụng
        definesPresentationContext = true
        //hien thi
        navigationItem.searchController = searchbar
        // Lấy ra mảng EarthQuake
        DataService.shared.getEarthQuake { [unowned self](arrEarthQuake) in
            self.arrEarthQuake = arrEarthQuake
//            self.filterEarthQuake = arrEarthQuake.sorted(by: { (a, b) -> Bool in
//                return String(a.city!) < String(b.city!)
//            })
            self.filterEarthQuake = arrEarthQuake
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterEarthQuake.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! EKCustomCell
        
        cell.loadCell(arrEarthQuake: filterEarthQuake, indexPath: indexPath)
        return cell
    }
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let webview = segue.destination as? Webview {
            if let indexPath = tableView.indexPathForSelectedRow {
                webview.bucketURL = filterEarthQuake[indexPath.row].webURL
                DataService.shared.selectedEarthQuake = filterEarthQuake[indexPath.row]
            }
        }
    }
    
    // searchBar
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
                let trimmedSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                filterEarthQuake = arrEarthQuake.filter({ (earthQuake) -> Bool in
                    return (earthQuake.place?.lowercased().contains(trimmedSearch.lowercased()))!
                })
        }
        else {
            filterEarthQuake = arrEarthQuake
        }
        tableView.reloadData()
    }
    
}




