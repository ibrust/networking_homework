//
//  TableViewCell.swift
//  networking_homework
//
//  Created by Field Employee on 10/27/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var cell_label_outlet: UILabel!
    @IBOutlet weak var cell_image_outlet: UIImageView!
    
    var image_loaded = false
    var id_loaded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
