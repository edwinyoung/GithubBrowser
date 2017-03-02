//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchBar: UISearchBar!
    var searchSettings: GithubDemo.GithubRepoSearchSettings?
    
    var repos: [GithubRepo]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
//        if searchSettings == nil {
//            let defaultSettings = NSDictionary()
//            
//        }
        
        
        
        
        // Perform the first search when the view controller first loads
        doSearch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repos = repos {
            return repos.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoCell
        
        let repo = repos![indexPath.row]
        let avatarURL = URL(string: repo.ownerAvatarURL!)
        let name = repo.name
        let owner = repo.ownerHandle
        let description = repo.repoDescription
        
        cell.repoName.text = name
        cell.ownerName.text = owner
        cell.repoDescription.text = description
        cell.userAvatar.setImageWith(avatarURL!)
        
        let stars = repo.stars
        if let stars = stars {
            var starf = Float(stars / 100)
            starf = starf / 10
            cell.stars.text = String(describing: starf) + "k"
        } else {
            cell.stars.text = String(describing: stars)
        }
        
        let forks = repo.forks
        if let forks = forks {
            var forkf = Float(forks / 100)
            forkf = forkf / 10
            cell.stars.text = String(describing: forkf) + "k"
        } else {
            cell.stars.text = String(describing: forks)
        }
        
        return cell
        
    }
    
    // Perform the search.
    fileprivate func doSearch() {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings!, successCallback: { (newRepos) -> Void in
            
            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }
            self.repos = newRepos
            self.tableView.reloadData()
            
            MBProgressHUD.hide(for: self.view, animated: true)
        }, error: { (error) -> Void in
            print(error)
        })
        
    }
    
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings?.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
