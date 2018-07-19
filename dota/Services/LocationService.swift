import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    static let shared = LocationService()
    let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    
}
