//
//  image_list_format.swift
//  networking_homework
//
//  Created by Field Employee on 10/27/20.
//

import UIKit

var starting_page = 1
var page_size = 10
var parsed_image_links = [json_image_link]()
var received_images = [UIImage?](repeating: nil, count: page_size)
var received_ids = [String?](repeating: nil, count: page_size)

struct json_image_link: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
    
    init(json: [String: Any]) {
        id = json["id"] as? String ?? ""
        author = json["author"] as? String ?? ""
        width = json["width"] as? Int ?? -1
        height = json["height"] as? Int ?? -1
        url = json["url"] as? String ?? ""
        download_url = json["download_url"] as? String ?? ""
    }
}



