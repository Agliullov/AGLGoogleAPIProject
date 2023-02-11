//
//  NetworkService.swift
//  AGLGoogleAPIProject
//
//  Created by Ильдар Аглиуллов on 06.02.2023.
//

import Foundation

protocol Networking: AnyObject {
    func request(urlString: String, _ completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkSevice {
    
    let queue: DispatchQoS
    
    init(queue: DispatchQoS = .utility) {
        self.queue = queue
    }
}

//MARK: - Network Service

extension NetworkSevice: Networking {
    
    func request(urlString: String, _ completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        createDataTask(from: request, completion: completion)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue(label: "AGLGoogleAPIProgect.NetworkService", qos: queue, attributes: .concurrent).async {
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, error == nil {
                    completion(data, nil)
                } else if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
    }
}
