import UIKit
#if DEBUG
import netfox
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
        NFX.sharedInstance().start()
        #endif
        return true
    }
}
