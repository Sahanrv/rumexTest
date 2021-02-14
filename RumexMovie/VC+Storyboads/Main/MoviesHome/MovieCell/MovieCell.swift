//
//  MovieCell.swift
//  RumexMovie
//
//  Created by Sahan Ravindu on 2021-02-14.
//

import UIKit


class MovieCell: UICollectionViewCell {
    
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
    }
    
    func setupUI() {
        cellView.addLayerEffects(cornerRadius: 4.0)
        bannerImgView.image = #imageLiteral(resourceName: "icons8-search")
    }
    
    func cellConfig(with model: Movie) {
        bannerImgView.setImageWithUrl(model.posterPath)
    }

}
