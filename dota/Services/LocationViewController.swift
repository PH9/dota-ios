import UIKit
import CoreLocation

final class LocationViewController: UIViewController, LocationServiceDelegate {
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!

    private var location: LocationService!

    override func viewDidLoad() {
        super.viewDidLoad()
        location = LocationService()
        location.delegate = self
    }

    func locationService(didUpdateLocations location: CLLocation?) {
        latLabel.text = "Lat: \(self.location.lastLatitude)"
        lonLabel.text = "Lon: \(self.location.lastLongitude)"
    }
}
