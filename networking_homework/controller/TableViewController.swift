//
//  TableViewController.swift
//  networking_homework
//
//  Created by Field Employee on 10/27/20.
//

import UIKit

class TableViewController: UITableViewController {

    var image_list_url: String = "https://picsum.photos/v2/list?page=\(starting_page)&limit=\(page_size)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        request_download_list(url: image_list_url)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableview_cell_id", for: indexPath) as? TableViewCell
        cell?.selectionStyle = .none
        
        if let received_id = received_ids[indexPath.row] {
            cell?.cell_label_outlet.text = "ID: " + received_id
        }
        if let received_image = received_images[indexPath.row] {
            print("in cellforrowat, indexpath.row: ", indexPath.row)
            cell?.cell_image_outlet.image = received_image
        }

        return cell ?? UITableViewCell()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func request_download_list(url: String){
        NetworkManager.shared.fetch_json_download_list(url) { [weak self] in ()
            guard let self = self else {return}
            DispatchQueue.main.async {
                for index in 0..<page_size{
                    self.request_single_image(index: index)
                }
            }
        }
    }
    
    func request_single_image(index: Int){
        let download_url = parsed_image_links[index].download_url

        NetworkManager.shared.fetch_image(download_url) { [weak self] (image, id) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                received_images[index] = image
                print("in the completion: ", index)
                let index_path = IndexPath(row: index, section: 0)
                let row_to_reload: [IndexPath] = [index_path]
                self.tableView.reloadRows(at: row_to_reload, with: .none)
            }
        }
    }

    private func set_image_list_url(page: Int, results_per_page: Int) -> String {
        return "https://picsum.photos/v2/list?page=\(page)&limit=\(results_per_page)"
    }
}
