//
//  Router.swift
//  TestProject
//
//  Created by Niyazov Makhmujan on 27.01.2023.
//

import Foundation
import UIKit

protocol RouterProtocol: AnyObject {
    var navigationController: UINavigationController? { get set }
    var diConteiner: DIConteinerProtocol? { get set }
    
    func initialViewController()
    func showDetailController(data: SearchResult?)
    func sharedGifViewController(data: SearchResult?)
}

class Router: RouterProtocol {
   
    var navigationController: UINavigationController?
    var diConteiner: DIConteinerProtocol?
    
    init(navigationController: UINavigationController, diConteiner: DIConteinerProtocol) {
        self.navigationController = navigationController
        self.diConteiner = diConteiner
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = diConteiner?.createMainViewController(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetailController(data: SearchResult?) {
        if let navigationController = navigationController {
            guard let detailController = diConteiner?.createDetailViewController(data: data,
                                                                                 router: self) else { return }
            navigationController.pushViewController(detailController, animated: true)
        }
    }
    
    func sharedGifViewController(data: SearchResult?) {
        if var navController = navigationController {
            guard let sharedController = diConteiner?.createSharedGifController(data: data, router: self) else { return }
            navController = UINavigationController(rootViewController: sharedController)
            
            if let sheet = navController.sheetPresentationController {
                sheet.detents = [.medium()]
            }
            
            navigationController?.present(navController, animated: true)
        }
    }
}
