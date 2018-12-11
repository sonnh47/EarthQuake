//
//  EKCustomCell.swift
//  EarthQuake
//
//  Created by Son on 11/19/18.
//  Copyright © 2018 NguyenHoangSon. All rights reserved.
//

import UIKit

class EKCustomCell: UITableViewCell {

    @IBOutlet weak var magLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadCell(arrEarthQuake: [EarthQuake], indexPath: IndexPath) {
        
        guard (arrEarthQuake[indexPath.row].mag) != nil else {return}
        self.magLabel.text = String(describing: arrEarthQuake[indexPath.row].mag!)
        guard arrEarthQuake[indexPath.row].distance != nil else {return}
        self.distanceLabel.text = String(describing: arrEarthQuake[indexPath.row].distance!)
        guard arrEarthQuake[indexPath.row].city != nil else {return}
        self.placeLabel.text = String(describing: arrEarthQuake[indexPath.row].city!)
        guard arrEarthQuake[indexPath.row].time != nil else {return}
        self.timeLabel.text = String(describing: arrEarthQuake[indexPath.row].time!)
        guard arrEarthQuake[indexPath.row].day != nil else {return}
        self.dateLabel.text = String(describing: arrEarthQuake[indexPath.row].day!)

    }
    
}
