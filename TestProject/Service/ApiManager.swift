//
//  ApiManager.swift
//  TestProject
//
//  Created by Niyazov Makhmujan on 26.01.2023.
//

import Foundation

protocol ApiManagerProtocol: AnyObject {
    func fetchAllGifs(completion: @escaping (Result<ResponseModel?, Error>) -> Void)
//    func fetchSearchResult(query:String, completion:@escaping ([GiphyData]?) -> Void)
}

enum APIEndPoints : String{
    case trending = "trending"
    case search = "search"
}

class ApiManager: ApiManagerProtocol {

    func endPoint(endPoint: APIEndPoints) -> String {
        return baseUrl + endPoint.rawValue
    }
    
    func endPoint(value: String) -> String {
        return baseUrl + value
    }
    
    private let baseUrl = "https://api.giphy.com/v1/gifs/"
    private let apiKey = "vE6Qt6CI8gxxkuEIIxEjU6CMxozZhmxe"
    
    //https://api.giphy.com/v1/gifs/categories?api_key=vE6Qt6CI8gxxkuEIIxEjU6CMxozZhmxe
    func fetchAllGifs(completion: @escaping (Result<ResponseModel?, Error>) -> Void) {

        guard let requestUrl = URL(string: endPoint(endPoint: .trending) + "?api_key=\(apiKey)&limit=50&rating=pg") else { return }

        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let decoder = JSONDecoder()
                guard let data = data else { return }
                let response = try decoder.decode(ResponseModel?.self, from: data)
                completion(.success(response))
                print(response!)
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
//    func fetchSearchResult(query: String, completion: @escaping ([GiphyData]?) -> Void) {
//        <#code#>
//    }
}
