//
//  APIRequest.swift
//  challenge
//
//  Created by Jacob Chan on 10/5/24.
//

import Foundation

public typealias JSON = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


public class BaseNetworkManager {
    let apiBaseUrl = Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
    
    func sendRequest<T: Decodable>(for: T.Type,
                                  url: String,
                                  method: RequestMethod,
                                  headers: HTTPHeaders? = nil,
                                  body: JSON? = nil,
                                  completion: @escaping (Result<T, NetError>) -> Void) {
        
        return sendRequest(url: url, method: method, headers: headers, body:body, completion: completion) { decoder, data in try decoder.decode(T.self, from: data)
        }
    }
    
    func sendRequest<T: Decodable>(for: [T].Type = [T].self,
                                  url: String,
                                  method: RequestMethod,
                                  headers: HTTPHeaders? = nil,
                                  body: JSON? = nil,
                                  completion: @escaping (Result<[T], NetError>) -> Void) {
        
        return sendRequest(url: url, method: method, headers: headers, body:body, completion: completion) { decoder, data in try decoder.decode([T].self, from: data)
        }
    }
    
    private func sendRequest(_ url: String,
                             method: RequestMethod,
                             headers: HTTPHeaders? = nil,
                             body: JSON? = nil,
                             completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string: url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        if let headers = headers {
            urlRequest.allHTTPHeaderFields = headers
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }

        if let body = body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            completionHandler(data, response, error)
        }
        
        task.resume()
    }
    
    private func sendRequest<T>(url: String,
                                method: RequestMethod,
                                headers: HTTPHeaders? = nil,
                                body: JSON? = nil,
                                completion: @escaping (Result<T, NetError>) -> Void,
                                decodingWith decode: @escaping (JSONDecoder, Data) throws -> T) {
        return sendRequest(url, method: method, headers: headers, body:body) { data, response, error in
            guard let data = data else {
                return completion(.failure(.validationError("Something went wrong")))
            }
            do {
                let decoder = JSONDecoder()
                // asking the custom decoding block to do the work
                try completion(.success(decode(decoder, data)))
            } catch let decodingError {
                completion(.failure(.ioError(decodingError.localizedDescription)))
            }
        }
    }
}
