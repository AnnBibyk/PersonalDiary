//
//  TableViewCell.swift
//  d09
//
//  Created by Anna BIBYK on 26.01.2019.
//  Copyright © 2019 Anna BIBYK. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var postTitle: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var createdAt: UILabel!
    
    @IBOutlet weak var updatedAt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
