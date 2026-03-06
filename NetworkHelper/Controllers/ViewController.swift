import UIKit
import Combine

final class ViewController: UIViewController {
    // MARK: Variables
    var users = [User]()
    var viewModel: UserViewModel?

    private var cancellables: Set<AnyCancellable> = []

    // MARK: Outlets
    @IBOutlet weak var tblUser: UITableView! {
        didSet {
            tblUser.dataSource = self
            tblUser.delegate = self
            tblUser.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        viewModel = UserViewModel()
        bindData()
        viewModel?.fetchUserList()
    }

    // MARK: - Bindings
    func bindData() {
        viewModel?.$users
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                self?.users = users
                self?.tblUser.reloadData()
            }
            .store(in: &cancellables)

        viewModel?.$error
            .compactMap { $0?.localizedDescription }
            .receive(on: DispatchQueue.main)
            .sink { errorMessage in
                print("User fetch error: \(errorMessage)")
            }
            .store(in: &cancellables)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].login
        cell.selectionStyle = .default
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let details = storyboard?.instantiateViewController(withIdentifier: "GetUserDetailViewController") as? GetUserDetailViewController else {
            return
        }
        details.userName = users[indexPath.row].login
        present(details, animated: true)
    }
}
