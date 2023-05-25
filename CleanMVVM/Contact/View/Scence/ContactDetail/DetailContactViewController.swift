//
//  DetailContactViewController.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 25/05/2023.
//

import UIKit

class DetailContactViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    var contact: Contact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "info contact"
        
        self.name.text = "name: \(contact.name)"
    
        self.phone.text = "phone: \(contact.phone)"
        
        self.email.text = "id: \(contact.id)"

    }
}
