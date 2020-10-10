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
    
    var users = [User]()
    let userVm = UserViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var tblUser: UITableView! {
        didSet {
            self.tblUser.dataSource = self
            self.tblUser.delegate = self
            self.tblUser.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userVm.fetchUserList()
        userVm.$users.sink { (user) in
            self.users = user ?? []
            self.tblUser.reloadData()
        }.store(in: &cancellables)
        
        userVm.$error.sink { (error) in
            print(error)
        }.store(in: &cancellables)
        
        setupViewModel()
    }
    
    func setupViewModel() {
        userVm.getUserList = { [weak self] (user, error) in
//            guard let _ = self else { return }
//            self!.users = user ?? []
//            self!.tblUser.reloadData()
        }
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

