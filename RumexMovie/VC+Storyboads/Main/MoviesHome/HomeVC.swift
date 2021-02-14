//
//  MainVC.swift
//  RumexMovie
//
//  Created by Sahan Ravindu on 2021-01-29.
//

import UIKit
import RxCocoa
import RxSwift

class HomeVC: BaseVC {
    
    //MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!{didSet{collectionView.rx.setDelegate(self).disposed(by: bag)}}
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var searchTF: UISearchBar!
    
    //MARK: Segment
    //Movies
    @IBOutlet weak var movieViewSelectView: UIView!
    @IBOutlet weak var moviesLB: UILabel!
    @IBOutlet weak var btnMovieSelect: UIButton!
    
    //TV Shows
    @IBOutlet weak var tvShowsViewSelectView: UIView!
    @IBOutlet weak var tvShowsLB: UILabel!
    @IBOutlet weak var btnTVShowsSelect: UIButton!
    
    //MARK:- Variables
    let vm = HomeVM()
    let bag = DisposeBag()
    let cellIdentifire = "MovieHomeCell"
    let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    let itemsPerRow: CGFloat = 2
    var isSearchView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addObservers()
        getMovies()
        addPullToRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(.yes)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideNavigationBar(.no)
    }
    
    func setupUI() {
        searchTF.alpha = 0
        searchTF.addLayerEffects(cornerRadius: 4.0)
        searchTF.delegate = self
    }
    
    func changeSelectedBtnUI() {
        
        switch vm.mode.value {
        case .populer:
            getMovies()
            movieViewSelectView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            tvShowsViewSelectView.backgroundColor = #colorLiteral(red: 0.1372345686, green: 0.1372663081, blue: 0.1372349262, alpha: 1)
            moviesLB.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            tvShowsLB.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
        case .upcoming:
            getTvShows()
            movieViewSelectView.backgroundColor = #colorLiteral(red: 0.1372345686, green: 0.1372663081, blue: 0.1372349262, alpha: 1)
            tvShowsViewSelectView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            moviesLB.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            tvShowsLB.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
        }
        
        searchTF.text = ""
        collectionView.setContentOffset(.zero, animated: true)
//        isSearchViewVisible()
        
    }
    
    func addObservers() {
        
        //MARK:- Event Observers
        btnSearch.rx.tap.subscribe() {[weak self] _ in
            self?.isSearchViewVisible()
        }.disposed(by: bag)
        
        btnMovieSelect.rx.tap.subscribe() {[weak self] _ in
            self?.vm.mode.accept(.populer)
        }.disposed(by: bag)
        
        btnTVShowsSelect.rx.tap.subscribe() {[weak self] _ in
            self?.vm.mode.accept(.upcoming)
        }.disposed(by: bag)
        
        vm.mode.asObservable().subscribe() {[weak self] _ in
            self?.changeSelectedBtnUI()
        }.disposed(by: bag)
        
        //MARK: Data Observers
        vm.movieList.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: cellIdentifire, cellType: MovieHomeCell.self)) { row, model, cell in
                cell.cellConfig(with: model)
            }
            .disposed(by: bag)
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.navigateToMovieDetail(with: indexPath.row)
        }).disposed(by: bag)
    }
    
    func isSearchViewVisible() {
        
        self.isSearchView = !self.isSearchView
        
        if self.isSearchView {
            self.searchTF.fadeIn()
        } else {
            self.searchTF.fadeOut()
            changeSelectedBtnUI()
        }
        
        view.endEditing(true)
    }
    
    func navigateToMovieDetail(with movieListIndex: Int) {
        
        let movie: Movie = vm.movieList.value[movieListIndex]
        ApplicationServiceProvider.shared.pushToViewController(in: .Main, for: .MovieDetailVC, from: self, data: movie)
        
    }
    
}

