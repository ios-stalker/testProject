//
//  SharedPresenter.swift
//  TestProject
//
//  Created by Niyazov Makhmujan on 30.01.2023.
//

import Foundation
import UIKit

protocol SharedPresenterView: AnyObject {
    func copyLink(with model: SearchResult?)
    func downloadImgFromUrl(with model: SearchResult?)
}

protocol SharedPresenterProtocol: AnyObject {
    init(view: SharedPresenterView, router: RouterProtocol, data: SearchResult?)
    var sharedModel: SearchResult? { get set }
    
    func copingLing()
    func downloadImage()
}

class SharedPresenter: SharedPresenterProtocol  {
   
    var sharedModel: SearchResult?
    var view: SharedPresenterView?
    var router: RouterProtocol
    
    required init(view: SharedPresenterView, router: RouterProtocol, data: SearchResult?) {
        self.view = view
        self.sharedModel = data
        self.router = router
    }
    
    func copingLing() {
        view?.copyLink(with: sharedModel)
    }
    
    func downloadImage() {
        view?.downloadImgFromUrl(with: sharedModel)
    }
}
