//
//  NetworkingManager.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//

import Foundation
import Combine
class NetworkingManager{
        enum NetworkingError: LocalizedError{
            case badServerResponse(url: URL)
            case unknown // khong xac dinh
            
            var errorDescription: String?{
                switch self {
                case .badServerResponse:
                   return "Bad reponse from URL"
                case .unknown:
                   return "Unknown error occured"
                }
            }
        }
    static func download(url: URL) -> AnyPublisher<Data, any Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
             .subscribe(on: DispatchQueue.global(qos: .default))
             .tryMap({ try handleURLResponse(output: $0, url: url)})
             .receive(on: DispatchQueue.main)
             .eraseToAnyPublisher()
    }
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data{
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else{
//            throw URLError(.badServerResponse)
            throw NetworkingError.badServerResponse(url: url)
        }
        return output.data
    }
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion{
        case .finished:// ketthuc
            break
        case .failure(let error)://that bai
            print(error.localizedDescription)
        }
    }
}
