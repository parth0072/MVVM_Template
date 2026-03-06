import UIKit
import Combine

final class GetUserDetailViewController: UIViewController {
    let userVm = UserViewModel()
    var cancellable = Set<AnyCancellable>()
    var userName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        if let userName {
            title = userName
            userVm.getUserDetails(userName: userName)
        }
    }

    private func bindData() {
        userVm.$userDetails
            .compactMap { $0?.login }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] login in
                self?.title = login
            }
            .store(in: &cancellable)

        userVm.$error
            .compactMap { $0?.localizedDescription }
            .sink { errorMessage in
                print("User details error: \(errorMessage)")
            }
            .store(in: &cancellable)
    }
}
