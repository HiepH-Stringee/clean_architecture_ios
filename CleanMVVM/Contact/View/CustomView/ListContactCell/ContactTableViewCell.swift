//
//  ContactTableViewCell.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 25/05/2023.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

}
