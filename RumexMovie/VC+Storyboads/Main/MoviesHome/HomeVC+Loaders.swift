//
//  HomeVC+Loaders.swift
//  RumexMovie
//
//  Created by Sahan Ravindu on 2021-02-14.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift


extension HomeVC {
    
    //MARK: Pulltorefresh
    func addPullToRefresh(){
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor =  #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
    }
    
    @objc func loadData() {
        self.collectionView!.refreshControl?.beginRefreshing()
        //code to execute during refresher
        
        switch self.vm.mode.value {
        case .populer:
            self.getMovies()
        case .upcoming:
            self.getTvShows()
        }
        stopRefresher()
    }
    
    func stopRefresher() {
        self.collectionView!.refreshControl?.endRefreshing()
        refresher.endRefreshing()
    }
    
    
    //MARK: Setup refreshing (Load more)
      // Set up top pull to refresh using PullToRefreshKit framework
      func setUpRefreshing() {
          let footer = self.configureLoadMoreFooter()
          
          let currentPage = vm.paginator?.currentPage ?? 0
          let lastPage = vm.paginator?.lastPage ?? 0
          
          if currentPage < lastPage {
              self.collectionView.configRefreshFooter(with: footer, container: self) {
                  self.delay(1.0, closure: {
                      self.collectionView.switchRefreshFooter(to: .normal)
                      self.manageLoadMore(page: (currentPage + 1))
                      self.collectionView.switchRefreshFooter(to: .removed)
                  })
              }
          } else {
              self.collectionView.switchRefreshFooter(to: .noMoreData)
          }
      }
      
      
      func delay(_ delay:Double, closure:@escaping ()->()) {
          DispatchQueue.main.asyncAfter(
              deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
      }
      
      
      func manageLoadMore(page: Int) {
        switch vm.mode.value {
        case .upcoming:
            self.getTvShows(page: page, isLoadMore: true)
        default:
            self.getMovies(page: page, isLoadMore: true)
        }
         
      }
}
