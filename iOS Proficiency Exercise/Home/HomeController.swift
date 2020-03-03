//
//  HomeController.swift
//  iOS Proficiency Exercise
//
//  Created by Nanda iMac on 25/02/20.
//  Copyright © 2020 Nanda. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {
    
    let videoCellId = "videoCellId"
    var videosFeedData: Video?
    
    //view model object
    var viewModel = HomeViewModel()
    
    var loadIndicator: UIActivityIndicatorView!
    var dragToRefreshControl: UIRefreshControl!
    var refreshLoader: Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableviewView()
        setupLoaderView()
        setupRefreshVideoFeed()
        loadVideoFeed()
        
    }
    
    func setupLoaderView() {
        
        loadIndicator = UIActivityIndicatorView()
        loadIndicator.color = .darkGray
        if #available(iOS 13.0, *) {
            loadIndicator.style = .large
        } else {
            loadIndicator.style = .whiteLarge
        }
        loadIndicator.translatesAutoresizingMaskIntoConstraints                      = false
        view.addSubview(loadIndicator)
        loadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupRefreshVideoFeed() {
        refreshLoader                        = false
        dragToRefreshControl                 = UIRefreshControl()
        dragToRefreshControl.attributedTitle = NSAttributedString(string: "Fetching....")
        dragToRefreshControl.tintColor       = .gray
        dragToRefreshControl.addTarget(self, action: #selector(refereshVideoFeed(_:)), for: .valueChanged)
        tableView.addSubview(dragToRefreshControl)
    }
    
    func setupTableviewView() {
        
        tableView.separatorStyle     = .none
        tableView.register(VideoCell.self, forCellReuseIdentifier: videoCellId)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight          = UITableView.automaticDimension
        
    }
    @objc func refereshVideoFeed(_ sender: AnyObject) {
        refreshLoader = true
        loadVideoFeed()
    }
    
    @objc func loadVideoFeed()  {
        if !refreshLoader {
            loadIndicator.startAnimating()
        }
        videosFeedData = nil
        tableView.reloadData()
        //API calling from viewmodel class
        viewModel.feedDelegate = self
        viewModel.fetchVideoFeed()
        
    }
    
}


extension HomeController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard videosFeedData != nil else {
            return 0
        }
        self.title = videosFeedData?.title ?? "Home"
        return videosFeedData?.rows?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let videoCell = tableView.dequeueReusableCell(withIdentifier: videoCellId) as! VideoCell
        videoCell.selectionStyle = .none
        videoCell.video = videosFeedData?.rows?[indexPath.row]
        return videoCell
    }
    
}


extension HomeController: HomeVideoFeedDelegate {
    
    // will fire when Viewmodel gets data
    func videoFeedData(_ status: Bool) {
        
      
        hideRefreshAnimation()
        guard status else {
            
            let errorMsg = self.viewModel.videoFeedFailed
            DispatchQueue.main.async {
              
                
                self.popupAlert(title: "Alert..!", message: errorMsg, actionTitles: ["Dismiss"], actions:[{ [weak self] dismissAction in
                    self?.dismiss(animated: true, completion: nil)
                    
                    }, nil])
            }
            
            return
        }
        
        self.videosFeedData = self.viewModel.videoFeedResult
        self.tableView.reloadData()
        
    }
    
    func hideRefreshAnimation() {
        DispatchQueue.main.async {
             self.loadIndicator.stopAnimating()
                   if self.dragToRefreshControl.isRefreshing == true {
                       self.dragToRefreshControl.endRefreshing()
                   }
        }
       
    }
    
    
}
