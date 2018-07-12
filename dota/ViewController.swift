import UIKit

final internal class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    let heroPresenter = HeroesPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        heroPresenter.delegate = self
        textView.text = "Loading..."
        heroPresenter.getHeros()
    }
}

extension ViewController: HeroesPresenterProtocol {
    func heroes(didFinishedWithSuccess heroes: [Hero]) {
        DispatchQueue.main.async {
            self.textView.text = heroes.debugDescription
            print(heroes.count)
        }
    }

    func heroes(didFinishedWithError error: Error) {
        DispatchQueue.main.async {
            self.textView.text = error.localizedDescription
        }
    }
}
