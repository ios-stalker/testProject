//
//  DIConteiner.swift
//  TestProject
//
//  Created by Niyazov Makhmujan on 27.01.2023.
//

import Foundation
import UIKit
protocol DIConteinerProtocol: AnyObject {
    func createMainViewController(router: RouterProtocol) -> UIViewController
    func createDetailViewController(data: SearchResult?, router: RouterProtocol) -> UIViewController
    func createSharedGifController(data: SearchResult?, router: RouterProtocol) -> UIViewController
}

class DiConteiner: DIConteinerProtocol {
 
    func createMainViewController(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = ApiManager()
        let presenter = MainPresenter(view: view, networkManger: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailViewController(data: SearchResult?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(
            view: view,
            router: router,
            data: data
        )
        view.presenter = presenter
        return view
        
    }
    
    func createSharedGifController(data: SearchResult?, router: RouterProtocol) -> UIViewController {
        let view = SharedViewController()
        let presenter = SharedPresenter(view: view, router: router, data: data)
        view.presenter = presenter
        return view
    }
    
    
}
