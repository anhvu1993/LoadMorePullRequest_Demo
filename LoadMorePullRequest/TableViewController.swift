//
//  ViewController.swift
//  LoadMorePullRequest
//
//  Created by Anh vũ on 4/9/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var list = [Int](1...20)
    var pageNumber = 0
    var pagetotal = 5
    var pageSize = 10
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMore()
    //        pullRequest
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshdata), for: .valueChanged)
        
    }
    @objc func refreshdata() {
        list = [Int](0...20)
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(list[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        loadMore
        if indexPath.row == list.count - 5 {
            guard pageNumber < pagetotal else { return}
            loadMore()
            
        }
    }
    func loadMore (){
        guard pageNumber < pagetotal else {return}
        let lastRequest = pageNumber == pagetotal - 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.list += [Int](0..<self.pageSize)
            self.tableView.reloadData()
            self.pageNumber += 1
            if lastRequest {
                self.activityView.stopAnimating()
            }
        }
    }
}
