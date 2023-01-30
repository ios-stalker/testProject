//
//  DetailViewController.swift
//  TestProject
//
//  Created by Niyazov Makhmujan on 27.01.2023.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    var presenter: DetailPresenterProtocol!
    
    private let detailGif: UIImageView = {
        let gif = UIImageView()
        gif.contentMode = .scaleToFill
        gif.translatesAutoresizingMaskIntoConstraints = false
        return gif
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(moveBack), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(shared), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupGif()
    }
    
    @objc func moveBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func shared() {
        presenter.transitionToShared()
    }
    
    private func setupGif() {
        [closeButton, shareButton, detailGif].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            
            shareButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            
            detailGif.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 30),
            detailGif.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            detailGif.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            detailGif.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2.5)
        ])
    }

}

extension DetailViewController: DetailViewProtocol {
    func setGif(with model: SearchResult?) {
        let url = URL(string: model?.images.downsized.url ?? "")
        detailGif.kf.setImage(with: url)
    }
}

