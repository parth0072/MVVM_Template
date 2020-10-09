//
//  ViewController.swift
//  NetworkHelper
//
//  Created by Parth on 09/10/20.
//  Copyright © 2020 Parth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var users = [User]()
    
    @IBOutlet weak var tblUser: UITableView! {
        didSet {
            self.tblUser.dataSource = self
            self.tblUser.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserViewModel.init().getUserList {[weak self] (user, error) in
            guard let _ = self else { return }
            self!.users = user ?? []
            self!.tblUser.reloadData()

        }
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = users[indexPath.row].login
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
}

