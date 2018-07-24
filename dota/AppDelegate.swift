import UIKit
import Fabric
import Crashlytics
#if DEBUG
import netfox
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
        DispatchQueue.main.async {
            NFX.sharedInstance().start()
        }
        #endif
        Fabric.with([Crashlytics.self])
        setupRootViewController()
        return true
    }

    func setupRootViewController() {
        let storyboard = UIStoryboard(name: "Location", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
    }
}
