
import Foundation

enum NetworkError: LocalizedError {
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingFailed
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid server response."
        case .invalidStatusCode(let code):
            return "Request failed with status code \(code)."
        case .decodingFailed:
            return "Failed to decode response data."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

protocol NetworkClientProtocol {
    func request<T: Decodable>(
        _ request: URLRequest,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

final class ConnectionManager: NetworkClientProtocol {
    static let shared = ConnectionManager()

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(
        _ request: URLRequest,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        session.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(.unknown(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode(httpResponse.statusCode)))
                return
            }

            guard let data else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
}
