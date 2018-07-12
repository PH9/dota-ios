import Alamofire

protocol HeroesPresenterProtocol: class {
    func heroes(didFinishedWithSuccess heroes: [Hero])
    func heroes(didFinishedWithError error: Error)
}

final class HeroesPresenter {
    weak var delegate: HeroesPresenterProtocol?
    let url = URL(string: "https://api.opendota.com/api/heroes")!

    func getHeros() {
        Alamofire.request(url).response(completionHandler: self.completionHandler).resume()
    }

    private func completionHandler(_ response: DefaultDataResponse) {
        if let error = response.error {
            self.delegate?.heroes(didFinishedWithError: error)
            return
        }

        if let data = response.data {
            let heroes = try! JSONDecoder().decode([Hero].self, from: data)
            self.delegate?.heroes(didFinishedWithSuccess: heroes)
            return
        }
    }
}
