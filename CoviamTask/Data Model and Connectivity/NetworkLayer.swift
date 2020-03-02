//
//  NetworkLayer.swift
//  CoviamTask
//
//  Created by Mraj singh on 02/03/20.
//  Copyright © 2020 Mraj singh. All rights reserved.
//

import Foundation

class API {
    
    let urlToRequest = "https://www.blibli.com/backend/search/products?"
    
    func sendRequest(parameters: [String: Any], completion: @escaping ([String: Any]?, Error?) -> Void) {
        var components = URLComponents(string: urlToRequest)!
        components.queryItems = parameters.map { (arg) -> URLQueryItem in
            
            let (key, value) = arg
            return URLQueryItem(name: key, value: value as? String)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,                            // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                error == nil else {                           // was there no error, otherwise ...
                    completion(nil, error)
                    return
            }

            let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
            if let dict = responseObject {
                completion(dict["data"] as? [String : Any] , nil)
            }
          
        }
        task.resume()
    }

    
    func convertToDictionary(text: String) -> [String: Any]? {
           if let data = text.data(using: .utf8) {
               do {
                   return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
               } catch {
                   print(error.localizedDescription)
               }
           }
           return nil
       }
}
