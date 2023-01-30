//
//  MainPresenter.swift
//  TestProject
//
//  Created by Niyazov Makhmujan on 27.01.2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success(data: ResponseModel?)
    func failure(error: Error)
}

protocol MainPresenterProtocol: AnyObject {
    var data: ResponseModel? { get set }
    init(view: MainViewProtocol, networkManger: ApiManagerProtocol, router: RouterProtocol)
    func tapOnTheGif(results: SearchResult?)
    func getGifs()
    
}
class MainPresenter: MainPresenterProtocol {
    var data: ResponseModel?
    weak var view: MainViewProtocol?
    let networkService: ApiManagerProtocol
    let router: RouterProtocol
    
    required init(view: MainViewProtocol, networkManger: ApiManagerProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkManger
        self.router = router
        getGifs()
    }
    
    func getGifs() {
        networkService.fetchAllGifs { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let gif):
                    self.data = gif
                    self.view?.success(data: gif)
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func tapOnTheGif(results: SearchResult?) {
        router.showDetailController(data: results)
    }
}
