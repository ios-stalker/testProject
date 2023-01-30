//
//  DetailPresenter.swift
//  TestProject
//
//  Created by Niyazov Makhmujan on 27.01.2023.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setGif(with model: SearchResult?)
}

protocol DetailPresenterProtocol: AnyObject {
    
    init(view: DetailViewProtocol, router: RouterProtocol, data: SearchResult?)
    var gifsData: SearchResult? { get set }
    func setGif()
    func transitionToShared()
}

class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    let router: RouterProtocol
    var gifsData: SearchResult?
    
    required init(view: DetailViewProtocol, router: RouterProtocol, data: SearchResult?) {
        self.view = view
        self.router = router
        self.gifsData = data
        setGif()
    }
    
    func setGif() {
        self.view?.setGif(with: gifsData)
    }
    
    func transitionToShared() {
        router.sharedGifViewController(data: gifsData)
    }
}
