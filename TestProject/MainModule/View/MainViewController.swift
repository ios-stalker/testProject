//
//  ViewController.swift
//  TestProject
//
//  Created by Niyazov Makhmujan on 26.01.2023.
//

import UIKit

class MainViewController: UIViewController {

    var presenter: MainPresenterProtocol!
    weak var mainView: MainViewProtocol?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .black
        collection.showsVerticalScrollIndicator = false
        collection.register(GiphyCell.self, forCellWithReuseIdentifier: GiphyCell.giphyId)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupCollectionLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCollectionLayout() {
        let layout = CollectionViewMosaicLayout()
        
        layout.minimumColumnSpacing = 3.0
        layout.minimumInteritemSpacing = 3.0
        
        collectionView.collectionViewLayout = layout
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.data?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiphyCell.giphyId,
                                                            for: indexPath) as? GiphyCell else { return UICollectionViewCell() }
        cell.setupData(data: (presenter.data?.data[indexPath.row])!)
        return cell
    }
}

extension MainViewController: CollectionViewDelegateMosaicLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int.random(in: 250..<500), height: Int.random(in: 250..<500))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountFor section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.tapOnTheGif(results: presenter.data?.data[indexPath.row])
    }
}

extension MainViewController: MainViewProtocol {
    func success(data: ResponseModel?) {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
