import UIKit

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

struct StoreItems: Codable {
    let results: [StoreItem]
}

struct StoreItem: Codable {
    var artistName: String
    var title: String
    var url: URL
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case title = "trackName"
        case url = "trackViewUrl"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.artistName = try valueContainer.decode(String.self, forKey: CodingKeys.artistName)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
    }
    
    static func fetchItems(_ query: [String: String], completion: @escaping ([StoreItem]?) -> Void) {
        let baseURL = URL(string: "https://itunes.apple.com/search?")!
        
        guard let url = baseURL.withQueries(query) else {
            completion(nil)
            print("Unable to build URL with supplied queries.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let storeItems = try? jsonDecoder.decode(StoreItems.self, from: data) {
                completion(storeItems.results)
            } else {
                print("Either no data was returned, or data was not serialized.")
                completion(nil)
                return
            }
        }
        task.resume()
    }
}

var query: [String: String] = ["term": "michael+jackson", "country": "US", "media": "music"]

StoreItem.fetchItems(query) { (storeItems) in
    guard let storeItems = storeItems else { return }
    print(storeItems)
}
