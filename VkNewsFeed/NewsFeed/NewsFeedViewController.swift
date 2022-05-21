//
//  NewsFeedViewController.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 13.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: AnyObject {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic, NewsFeedCodeCellDelegate {
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
      
    @IBOutlet weak var feedsTableView: UITableView!
    
    private var feedViewModel = FeedViewModel(cells: [], footerTitle: nil)
    
    private var titleView = TitleView()
    
    private lazy var footerView = FooterView()
    
    private var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        let router                = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setUpTopBars()
        setUpFeedsTableView()
        
        interactor?.makeRequest(request: .getNewsFeed)
        interactor?.makeRequest(request: .getUser)
    }
    
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
        case .displayNewsFeed(let feedViewModel):
            self.feedViewModel = feedViewModel
            feedsTableView.reloadData()
            refreshControl.endRefreshing()
            footerView.setTitle(feedViewModel.footerTitle)
       
        case .displayUser(userViewModel: let userViewModel):
            titleView.set(userViewModel: userViewModel)
      
        case .displayFooterLoader:
            footerView.showLoader()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            interactor?.makeRequest(request: .getNextBatch)
        }
    }

    private func setUpTopBars() {
        
        if let statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame {
            let topBar = UIView(frame: statusBarFrame)
            self.view.addSubview(topBar)
            topBar.backgroundColor = .white
            topBar.layer.shadowColor = UIColor.black.cgColor
            topBar.layer.shadowOpacity = 0.3
            topBar.layer.shadowOffset = CGSize.zero
            topBar.layer.shadowRadius = 8
        }
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
        
    }
    
    private func setUpFeedsTableView() {
        
        let topInset: CGFloat = 8
        
        feedsTableView.contentInset.top = topInset
        
        feedsTableView.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.reuseId)
        feedsTableView.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
        
        feedsTableView.separatorStyle = .none
        feedsTableView.backgroundColor = .clear
        
        feedsTableView.tableFooterView = footerView
        
        feedsTableView.addSubview(refreshControl)
    }
    
    @objc private func refresh() {
        interactor?.makeRequest(request: .getNewsFeed)

    }
    
    //MARK: NewsFeedCodeCellDelegate
    
    func revealPost(for cell: NewsFeedCodeCell) {
        guard let indexPath = feedsTableView.indexPath(for: cell) else { return }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        interactor?.makeRequest(request: .revealPostIds(postId: cellViewModel.postId))
        
    }
    
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedViewModel.cells.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedCell", for: indexPath) as! NewsFeedCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseId, for: indexPath) as! NewsFeedCodeCell
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
}


