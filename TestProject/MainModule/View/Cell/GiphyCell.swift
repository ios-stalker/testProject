//
//  GiphyCell.swift
//  TestProject
//
//  Created by Niyazov Makhmujan on 26.01.2023.
//

import UIKit
import Kingfisher

class GiphyCell: UICollectionViewCell {
    
    static let giphyId = "giphyId"
    
    private let giphyGifImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let giphyBackView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImage() {
        contentView.addSubview(giphyBackView)
        giphyBackView.addSubview(giphyGifImage)
        
        NSLayoutConstraint.activate([
            giphyBackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            giphyBackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            giphyBackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            giphyBackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            giphyGifImage.topAnchor.constraint(equalTo: giphyBackView.topAnchor),
            giphyGifImage.leadingAnchor.constraint(equalTo: giphyBackView.leadingAnchor),
            giphyGifImage.trailingAnchor.constraint(equalTo: giphyBackView.trailingAnchor),
            giphyGifImage.bottomAnchor.constraint(equalTo: giphyBackView.bottomAnchor)
        ])
    }
    
    func setupData(data: SearchResult) {
        let url = URL(string: data.images.downsized.url)
        giphyGifImage.kf.setImage(with: url)
        giphyBackView.backgroundColor = setBackgroundColor()
    }
    
    private func setBackgroundColor() -> UIColor {
        let red: CGFloat = CGFloat(drand48())
        let green: CGFloat = CGFloat(drand48())
        let blue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
