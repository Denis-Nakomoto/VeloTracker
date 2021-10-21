//
//  NetworkService.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 22.09.2021.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func getComments(completion: @escaping(Result<[Comment]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getComments(completion: @escaping (Result<[Comment]?, Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/comments"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
//
//            let dataString = String(decoding: data!, as: UTF8.self)
//                                                            print("JSON: \(dataString)")
            
            
            do {
                let obj = try JSONDecoder().decode([Comment].self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        } .resume()
                
    }
    
    
}
