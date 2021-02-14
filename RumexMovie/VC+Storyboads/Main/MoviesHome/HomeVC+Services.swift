//
//  HomeVC+Services.swift
//  RumexMovie
//
//  Created by Sahan Ravindu on 2021-02-14.
//

extension HomeVC {
    
    func getMovies(page: Int = 1, isLoadMore: Bool = false) {
        
        startLoading(isLoadMore: isLoadMore)
        vm.getMovies(page: page, isLoadMore: isLoadMore) { (success, statusCode, message) in
            self.stopLoading()
            if !success {
                AlertProvider(vc: self).showAlert(title: .Error, message: message, action: AlertAction.init(title: .Dismiss))
            } else {
                // Hadle function after register
                self.setUpRefreshing()
                print("PREFFERED LIST: \(self.vm.movieList.value)")
                
            }
            
        }
    }
    
    func getTvShows(page: Int = 1, isLoadMore: Bool = false) {
        
        startLoading(isLoadMore: isLoadMore)
        vm.getTVShows(page: page, isLoadMore: isLoadMore) { (success, statusCode, message) in
            self.stopLoading()
            if !success {
                AlertProvider(vc: self).showAlert(title: .Error, message: message, action: AlertAction.init(title: .Dismiss))
            } else {
                // Hadle function after register
                self.setUpRefreshing()
                print("PREFFERED LIST: \(self.vm.movieList.value)")
                
            }
            
        }
    }
    
    func getSearchMovies(searchText: String? = nil) {
        
        startLoading()
        vm.getSearchMovies(searchText: searchText) { (success, statusCode, message) in
            self.stopLoading()
            if !success {
                AlertProvider(vc: self).showAlert(title: .Error, message: message, action: AlertAction.init(title: .Dismiss))
            } else {
                print("PREFFERED LIST: \(self.vm.movieList.value)")
                
            }
            
        }
    }
    
    
}
