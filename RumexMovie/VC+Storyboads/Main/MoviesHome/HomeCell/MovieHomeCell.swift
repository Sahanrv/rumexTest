//
//  MovieHomeCell.swift
//  RumexMovie
//
//  Created by Sahan Ravindu on 2021-02-14.
//

import UIKit
import Kingfisher

class MovieHomeCell: UICollectionViewCell {
    
    //MARK:- Variables
    
    //MARK:- Outlets
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var bannerImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }
    
    override func prepareForReuse() {
        setupUI()
        bannerImgView.image = #imageLiteral(resourceName: "movie")
    }
    
    func setupUI() {
        cellView.addLayerEffects(cornerRadius: 4.0)
    }
    
    func cellConfig(with model: Movie) {
        bannerImgView.setImageWithUrl("\(ApplicationServiceProvider.shared.imagePath)\(model.posterPath)")
        
    }
}
