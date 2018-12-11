
import Foundation

typealias JSON = Dictionary<AnyHashable, Any>

class EarthQuake {
    
    var mag: Float?
    var place: String?
    var date: Double?
    var webURL: String?
    var detail: String?
    var longitude: String?
    var latitude: String?
    var coordinate: String?
    var eventime: String?
    
    var distance: String?
    var city: String?
    var time: String?
    var day: String?
    var hasDetails: Bool = false
    
    init?(dict: JSON) {
        
        guard let mag = dict["mag"] as? Float else {return nil}
        guard let place = dict["place"] as? String else {return nil}
        guard let timeInterval = dict["time"] as? Double else {return nil}
        guard let webURL = dict["url"] as? String else {return nil}
        guard let detail = dict["detail"] as? String else {return nil}
        
        // cut Place
        if place.contains(" of ") == true {
            let cutPlace = place.components(separatedBy: " of ")
            self.distance = cutPlace.first! + " of "
            self.city = cutPlace.last
        }
        else {
            self.distance = "NEAR THE"
            self.city = place
        }
        // cut Date
        let cutDate = getDateStringFromUTC(timeInterval/1000).components(separatedBy: ".")
        self.time = cutDate.last
        self.day = cutDate.first
        
        self.mag = mag
        self.place = place
        self.date = timeInterval
        self.webURL = webURL
        self.detail = detail
        
    }
    // get Detail Selected
    func loadDetail(completionHandler: @escaping (EarthQuake) -> Void)  {
        guard !hasDetails else {return}
        DataService.shared.requestAPI(urlString: self.detail!, completionHandle: { (json) in
            guard let detailProperties = json["properties"] as? JSON else { return }
            guard let products = detailProperties["products"] as? JSON else {return}
            guard let origin = products["origin"] as? [JSON] else {return}
            guard let properties = origin[0]["properties"] as? JSON else {return}
            
            self.latitude = properties["latitude"] as? String
            self.longitude = properties["longitude"] as? String
            let latitude = (self.latitude! as NSString).floatValue
            let longitude = (self.longitude! as NSString).floatValue
            self.coordinate = self.coordinateString(latitude, longitude)
            self.eventime = properties["eventtime"] as? String
            self.hasDetails = true
            
        })
        completionHandler(self)
    }
    // cpnvert coordinate
    func coordinateString(_ latitude: Float,_ longitude: Float) -> String {
        return String(format:"%.3f°%@ %.3f°%@",
                      abs(latitude), latitude >= 0 ? "N" : "S",
                      abs(longitude), longitude >= 0 ? "E" : "W" )
    }
    // convert time to date
    func getDateStringFromUTC(_ number: Double) -> String {
        let date = Date(timeIntervalSince1970: number)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy'.'h:mm a"
        return dateFormatter.string(from: date)
    }
    
}




