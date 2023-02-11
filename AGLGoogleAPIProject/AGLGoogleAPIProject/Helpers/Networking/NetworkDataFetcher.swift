//
//  NetworkDataFetcher.swift
//  AGLGoogleAPIProject
//
//  Created by Ильдар Аглиуллов on 06.02.2023.
//

import Foundation

protocol NetworkDataProtocol {
    func getDataURLFromJson<T: Codable>(urlString: String, response: @escaping (T?) -> Void)
}

final class NetworkDataFetcher {
    
    private var networking: Networking
    
    init(networking: Networking = NetworkSevice()) {
        self.networking = networking
    }
}

extension NetworkDataFetcher: NetworkDataProtocol {
    
    func getDataURLFromJson<T>(urlString: String, response: @escaping (T?) -> Void) where T : Decodable {
        networking.request(urlString: urlString) { (data, error) in
            if let data = data {
                let decoded = self.decodeJSONData(type: T.self, from: data)
                response(decoded)
            } else if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
    private func decodeJSONData<T>(type: T.Type, from: Data?) -> T? where T : Decodable {
        guard let data = from else { return nil }
        let decoder = JSONDecoder()
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON: \(jsonError.localizedDescription)")
            return nil
        }
    }
}
