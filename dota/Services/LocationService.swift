import CoreLocation

protocol LocationServiceDelegate: class {
    func locationService(didUpdateLocations location: CLLocation?)
}

class LocationService: NSObject, CLLocationManagerDelegate {

    static let shared: LocationService = {
        if Thread.isMainThread {
            return LocationService()
        } else {
            return DispatchQueue.main.sync {
                return LocationService()
            }
        }
    }()

    private let locationManager = CLLocationManager()
    var location: CLLocation?
    var lastestMarker: CLPlacemark?

    weak var delegate: LocationServiceDelegate?

    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 5.0
        locationManager.delegate = self

        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .notDetermined:
            locationManager.requestAlwaysAuthorization()
        default:
            // TODO: 
            break
        }

        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
        delegate?.locationService(didUpdateLocations: location)
    }

    var lastLatitude: String? {
        guard let lat = location?.coordinate.latitude else {
            return nil
        }

        return String(lat)
    }

    var lastLongitude: String? {
        guard let lon = location?.coordinate.longitude else {
            return nil
        }

        return String(lon)
    }
}
