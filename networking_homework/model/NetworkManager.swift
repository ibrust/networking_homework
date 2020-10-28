//
//  NetworkManager.swift
//  networking_homework
//
//  Created by Field Employee on 10/27/20.
//

import UIKit



public final class NetworkManager{
    static var shared = NetworkManager()
    var session: URLSession
    
    private init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch_json_download_list(_ url: String, completion: @escaping () -> () ){
        guard let url_obj = URL(string:url) else{return}
        session.dataTask(with: url_obj){ (data, response, error) in
            if let _ = error{return}
            guard let data = data else{return}
            
            do {
                parsed_image_links = try JSONDecoder().decode(Array<json_image_link>.self, from: data)
                for index in 0..<parsed_image_links.count{
                    received_ids[index] = parsed_image_links[index].id
                }
                completion()
            } catch let json_error {print("error unserializing json: ", json_error)}
            return
        }.resume()
    }
    
    func fetch_image(_ url: String, completion: @escaping (UIImage?, String?) -> () ){
        guard let url_obj = URL(string:url) else{return}
        session.dataTask(with: url_obj){ (data, response, error) in
            if let _ = error{return}
            guard let data = data else{return}
            var id: String?
            
            if let result = response as? HTTPURLResponse {
                id = result.value(forHTTPHeaderField: "picsum-id")
            }
            completion(UIImage(data: data), id)
            return
        }.resume()
    }
}

