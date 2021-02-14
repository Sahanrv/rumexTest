//
//  AuthVC.swift
//  RumexMovie
//
//  Created by Sahan Ravindu on 2021-01-29.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class MovieDetailVC: BaseVC {
    
    //MARK:- Outlets
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var bannerImgView: UIImageView!
    @IBOutlet weak var titleImgView: UIImageView!
    @IBOutlet weak var isAdultLB: UILabel!
    @IBOutlet weak var languageLB: UILabel!
    @IBOutlet weak var overviewLB: UILabel!
    
    //MARK:- Variables
    var vm = MovieDetailVM()
    let bag = DisposeBag()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationBarTransparent(.yes)
        setupUI()
        setupData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationBarTransparent(.no)
        
    }
    
    func setupUI() {
        bannerImgView.addLayerEffects(cornerRadius: 4.0)
        titleImgView.addLayerEffects(cornerRadius: 4.0)
    }
    
    func setupData() {
        
        guard let movie = vm.movie else {
            self.goBack()
            return
        }
        
        titleLB.text = movie.originalTitle
        bannerImgView.setImageWithUrl("\(ApplicationServiceProvider.shared.imagePath)\(movie.posterPath)")
        titleImgView.setImageWithUrl("\(ApplicationServiceProvider.shared.imagePath)\(movie.posterPath)")
        isAdultLB.text = movie.adult ? "Yes" : "No"
        languageLB.text = movie.originalLanguage
        overviewLB.text = movie.overview
        
    }
    

}
