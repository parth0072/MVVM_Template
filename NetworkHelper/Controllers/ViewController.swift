//
//  ViewController.swift
//  NetworkHelper
//
//  Created by Parth on 09/10/20.
//  Copyright © 2020 Parth. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    // MARK: Variables
    var users = [User]()
    var viewModel: UserViewModel?
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Outlets
    @IBOutlet weak var tblUser: UITableView! {
        didSet {
            self.tblUser.dataSource = self
            self.tblUser.delegate = self
            self.tblUser.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserViewModel()
        viewModel?.fetchUserList()
        bindData()
    }
    
    //Bind Data
    func bindData() {
        viewModel?.$users.sink {[weak self] (user) in
            guard let `self` = self else { return }
            self.users = user
            self.tblUser.reloadData()
        }.store(in: &cancellables)
        
        viewModel?.$error.sink {[weak self] (error) in
            print(error)
        }.store(in: &cancellables)
    }

}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = users[indexPath.row].login
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = self.storyboard?.instantiateViewController(withIdentifier: "GetUserDetailViewController") as! GetUserDetailViewController
        details.userName = users[indexPath.row].login
        self.present(details, animated: true, completion: nil)
    }
}

