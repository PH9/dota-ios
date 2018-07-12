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

        guard 200 ..< 300 ~= (response.response?.statusCode ?? 0) else {
            self.delegate?.heroes(didFinishedWithError: APIServiceError.unacceptableHTTPStatus)
            return
        }

        guard let data = response.data else {
            self.delegate?.heroes(didFinishedWithError: APIServiceError.responseDataNotFound)
            return
        }

        guard let heroes = try? JSONDecoder().decode([Hero].self, from: data) else {
            self.delegate?.heroes(didFinishedWithError: APIServiceError.couldNotParseJSONValue)
            return
        }

        self.delegate?.heroes(didFinishedWithSuccess: heroes)
    }
}
