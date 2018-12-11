//
//  SelectedEarthQuake.swift
//  EarthQuake
//
//  Created by Son on 11/30/18.
//  Copyright © 2018 NguyenHoangSon. All rights reserved.
//

import UIKit

enum CellType: Int {
    case mag
    case place
    case date
    case coordinate
    case eventtime
    
    func needToShow(_ SelectedEarthQuake: EarthQuake) -> Bool {
        switch self {
        case .mag:
            return SelectedEarthQuake.mag != nil
        case .place:
            return !checkString(string: SelectedEarthQuake.place)
        case .date:
            return SelectedEarthQuake.date != nil
        case . coordinate:
            return !checkString(string: SelectedEarthQuake.coordinate)
        case .eventtime:
            return !checkString(string: SelectedEarthQuake.eventime)
        default:
            print("Error")
        }
    }
    
    func checkString(string: String?) -> Bool {
        guard let aString = string else {return true}
        if aString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        return false
    }
}

class SelectedEarthQuake: UITableViewController {
    
    @IBOutlet weak var magOutlet: UILabel!
    @IBOutlet weak var placeOutlet: UILabel!
    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var coordinateOutlet: UILabel!
    @IBOutlet weak var eventtimeOutlet: UILabel!
    
    let selectedEarthQuake = DataService.shared.detailEarthQuake
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        magOutlet.text = String(describing: selectedEarthQuake?.mag)
        placeOutlet.text = selectedEarthQuake?.place
        dateOutlet.text = String(describing: selectedEarthQuake?.date)
        coordinateOutlet.text = selectedEarthQuake?.coordinate
        eventtimeOutlet.text = selectedEarthQuake?.eventime
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cellType = CellType(rawValue: indexPath.row) {
            return cellType.needToShow(selectedEarthQuake!) ? (-1):(0)
        }
        return 0
    }
    
}
