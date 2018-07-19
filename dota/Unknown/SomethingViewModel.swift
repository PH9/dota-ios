import UIKit.UIImage

struct SomethingViewModel {
    let original: Something

    var image: UIImage? {
        return UIImage(named: original.imageName)
    }

    var title: String {
        return original.title
    }

    var body: String {
        return original.body
    }
}
