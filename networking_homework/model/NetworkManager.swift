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
        
        /* https://picsum.photos/id/117/1544/1024 */
        
        var total_slashes_found = 0
        var base_string = ""
        var first_size = ""
        var second_size = ""
        for char in url{
            if total_slashes_found < 5{
                base_string += String(char)
            }
            if char == "/" && total_slashes_found < 5{
                total_slashes_found += 1
                continue
            }
            if total_slashes_found == 5{
                if char != "/"{
                    first_size += String(char)
                } else {
                    total_slashes_found += 1
                }
            }
            if total_slashes_found == 6{
                if char != "/"{
                    second_size += String(char)
                }
            }
        }
        first_size = String(Int(first_size)! / 10)
        second_size = String(Int(second_size)! / 10)
        
        let modified_url = base_string + first_size + "/" + second_size

        guard let url_obj = URL(string:modified_url) else{return}
        session.dataTask(with: url_obj){ (data, response, error) in
            if let _ = error{print("ERROR");return}
            guard let data = data else{print("ERROR");return}
            var id: String?
            
            if let result = response as? HTTPURLResponse {
                id = result.value(forHTTPHeaderField: "picsum-id")
            }
            completion(UIImage(data: data), id)
            return
        }.resume()
    }
}

