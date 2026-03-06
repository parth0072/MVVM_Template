import Foundation
import Combine

protocol UserServicing {
    func fetchUsers(since: Int, completion: @escaping (Result<[User], NetworkError>) -> Void)
    func fetchUser(username: String, completion: @escaping (Result<User, NetworkError>) -> Void)
}

final class DefaultUserService: UserServicing {
    private let client: ConnectionManager

    init(client: ConnectionManager = .shared) {
        self.client = client
    }

    func fetchUsers(since: Int, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        client.fetchUsers(since: since, completion: completion)
    }

    func fetchUser(username: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        client.fetchUser(username: username, completion: completion)
    }
}

final class UserViewModel {
    private let userService: UserServicing
    private let initialUserOffset: Int

    @Published var users = [User]()
    @Published var error: NetworkError?
    @Published var userDetails: User?

    init(userService: UserServicing = DefaultUserService(), initialUserOffset: Int = 0) {
        self.userService = userService
        self.initialUserOffset = initialUserOffset
    }

    func fetchUserList() {
        userService.fetchUsers(since: initialUserOffset) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.users = users
                    self?.error = nil
                case .failure(let error):
                    self?.users = []
                    self?.error = error
                }
            }
        }
    }

    func getUserDetails(userName: String) {
        userService.fetchUser(username: userName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.userDetails = user
                    self?.error = nil
                case .failure(let error):
                    self?.userDetails = nil
                    self?.error = error
                }
            }
        }
    }
}
