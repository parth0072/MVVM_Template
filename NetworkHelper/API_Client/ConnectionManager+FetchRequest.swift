import Foundation

extension ConnectionManager {
    func fetchUsers(since: Int, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        var components = URLComponents(url: API.baseURL.appendingPathComponent(API.usersPath), resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "since", value: String(since))]

        guard let url = components?.url else {
            completion(.failure(.invalidResponse))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request(request, completion: completion)
    }

    func fetchUser(username: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        let escapedUsername = username.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? username
        let url = API.baseURL
            .appendingPathComponent(API.usersPath)
            .appendingPathComponent(escapedUsername)

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request(request, completion: completion)
    }

    static func fetchUsers(since: Int, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        shared.fetchUsers(since: since, completion: completion)
    }

    static func fetchUser(username: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        shared.fetchUser(username: username, completion: completion)
    }
}

extension API {
    static let usersPath = "users"
}
