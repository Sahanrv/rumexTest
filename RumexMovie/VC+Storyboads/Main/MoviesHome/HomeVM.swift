//
//  HomeVM.swift
//  RumexMovie
//
//  Created by Sahan Ravindu on 2021-02-14.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeVM: BaseVM {
    
    var movieList = BehaviorRelay<[Movie]>(value: [])
    var mode = BehaviorRelay<MovieType>(value: .populer)
    var paginator: Paginator?
    
    //MARK:- Service
    
    func getMovies(page: Int, isLoadMore: Bool = false ,completion: @escaping completionHandler) {
        
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, .InternetConnectionOffline)
            return
        }
        
        APIClient.getMovies(page: 1, completion: { (result) in
            switch result {
            case .success(let responseModel):
                if isLoadMore {
                    var tempMovies:[Movie] = self.movieList.value
                    tempMovies.append(contentsOf: responseModel.results)
                    self.movieList.accept(tempMovies)
                    
                } else {
                    self.movieList.accept(responseModel.results)
                }
                
                self.paginator = Paginator(currentPage: responseModel.page, lastPage: responseModel.totalPages, perPage: responseModel.totalResults)
                
                completion(true, 200, .Success)
            case .failure(let error):
                
                completion(false, 404, "Registration failed \(error.localizedDescription)")
            }
            
        })
    }
    
    func getTVShows(page: Int, isLoadMore: Bool = false,completion: @escaping completionHandler) {
        
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, .InternetConnectionOffline)
            return
        }
        
        APIClient.getTVShows(page: 1, completion: { (result) in
            switch result {
            case .success(let responseModel):
                if isLoadMore {
                    var tempMovies:[Movie] = self.movieList.value
                    tempMovies.append(contentsOf: responseModel.results)
                    self.movieList.accept(tempMovies)
                    
                } else {
                    self.movieList.accept(responseModel.results)
                }
                
                self.paginator = Paginator(currentPage: responseModel.page, lastPage: responseModel.totalPages, perPage: responseModel.totalResults)
                
                completion(true, 200, .Success)
            case .failure(let error):
                
                completion(false, 404, "Registration failed \(error.localizedDescription)")
            }
            
        })
    }
    
    func getSearchMovies(searchText: String? = nil ,completion: @escaping completionHandler) {
        
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, .InternetConnectionOffline)
            return
        }
        
        APIClient.getTVShows(page: 1, completion: { (result) in
            switch result {
            case .success(let responseModel):
                self.movieList.accept(responseModel.results)
                
                completion(true, 200, .Success)
            case .failure(let error):
                
                completion(false, 404, "Registration failed \(error.localizedDescription)")
            }
            
        })
    }
}


