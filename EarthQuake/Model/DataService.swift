//
//  AllData.swift
//  EarthQuake
//
//  Created by Son on 11/20/18.
//  Copyright © 2018 NguyenHoangSon. All rights reserved.
//

import Foundation
import SystemConfiguration
class DataService {
    private init(){}
    
    let urlString = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_week.geojson"
    static var shared = DataService()
    var request: URLRequest?
    var arrEarthQuake: [EarthQuake] = []
    var detailEarthQuake: EarthQuake?
    var selectedEarthQuake: EarthQuake? {
        didSet {
            selectedEarthQuake?.loadDetail(completionHandler: { (json) in
                self.detailEarthQuake = json
            })
        }
    }
    
    //getData
    func getEarthQuake(completion: @escaping ([EarthQuake]) -> Void) {
        requestAPI(urlString: urlString) { json in
            if let arrJSON = json["features"] as? [JSON] {
                for objectEQ in arrJSON {
                    if let objectEQDict = objectEQ["properties"] as? JSON {
                        self.arrEarthQuake.append(EarthQuake(dict: objectEQDict)!)
                    }
                }
                completion(self.arrEarthQuake)
            }
        }
    }
    
    // request API
    func requestAPI(urlString: String, completionHandle: @escaping (JSON) -> Void ) {
        guard let url = URL(string: urlString) else {return}
        
        isInternetAvailable() == true ? (request = URLRequest(url: url)):(request = URLRequest(url: url, cachePolicy: .returnCacheDataDontLoad, timeoutInterval: 5))
        
        URLSession.shared.dataTask(with: request!)  { (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return}
            guard let arrJSON = try? JSONSerialization.jsonObject(with: data!, options: []) else { return }
            guard let json = arrJSON as? JSON else {  return }
            DispatchQueue.main.async {
                completionHandle(json)
            }
            }.resume()
    }
    
    
    // check connection Internet
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
}



