//
//  SharedViewController.swift
//  TestProject
//
//  Created by Niyazov Makhmujan on 28.01.2023.
//

import UIKit
import Kingfisher

class SharedViewController: UIViewController {
    
    var presenter: SharedPresenterProtocol!
    
    private let sharedStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.contentMode = .scaleAspectFill
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var shareGifLinkButton: UIButton = {
        let shareButton = UIButton()
        shareButton.setTitle("Copy Gif Link", for: .normal)
        shareButton.backgroundColor = #colorLiteral(red: 0.3398793042, green: 0.3005904555, blue: 0.9978783727, alpha: 1)
        shareButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        shareButton.setTitleColor(UIColor.white, for: .normal)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.addTarget(self, action: #selector(copyGifLink), for: .touchUpInside)
        return shareButton
    }()
    
    private lazy var copyGifButton: UIButton = {
        let copyGifButton = UIButton()
        copyGifButton.setTitle("Copy Gif", for: .normal)
        copyGifButton.backgroundColor = #colorLiteral(red: 0.1145901456, green: 0.1096362248, blue: 0.1225956753, alpha: 1)
        copyGifButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        copyGifButton.setTitleColor(UIColor.white, for: .normal)
        copyGifButton.translatesAutoresizingMaskIntoConstraints = false
        copyGifButton.addTarget(self, action: #selector(downloadImage), for: .touchUpInside)
        return copyGifButton
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(transiotionToBack), for: .touchUpInside)
        return cancelButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        view.backgroundColor = .clear
    }
    
    @objc func copyGifLink() {
        presenter.copingLing()
    }
    
    @objc func transiotionToBack() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc func downloadImage() {
        presenter.downloadImage()
    }
    private func setupButtons() {
        view.addSubview(sharedStack)
        [shareGifLinkButton, copyGifButton, cancelButton].forEach { sharedStack.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            sharedStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sharedStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sharedStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            sharedStack.heightAnchor.constraint(equalToConstant: view.frame.size.height / 5),
        ])
    }
}

extension SharedViewController: SharedPresenterView {
    func downloadImgFromUrl(with model: SearchResult?) {
        guard let gifUrl = URL(string: model?.images.downsized.url ?? "") else { return }
        guard let imageData = try? Data(contentsOf: gifUrl) else { return }
        let activityController = UIActivityViewController(activityItems: [imageData], applicationActivities: nil)
        navigationController?.present(activityController, animated: true)
        print("\(gifUrl)")
    }
    
    func copyLink(with model: SearchResult?) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = model?.images.downsized.url
    }
}


