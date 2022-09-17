//
//  EmpDetailsCell.swift
//  EmployeeApp
//
//  Created by InApp on 17/09/22.
//

import UIKit
import SDWebImage
class EmpDetailsCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var webSiteLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setEmpData(model:Employee?){
        
        nameLabel.text = model?.name ?? " "
        userNameLabel.text = model?.username ?? " "
        emailLabel.text = model?.email ?? " "
        addressLabel.text = "\(model?.address?.city ?? " "),\(model?.address?.street ?? " "),\(model?.address?.suite ?? " ")\nZip:\(model?.address?.zipcode ?? " ")"
        phoneLabel.text = (model?.phone?.count ?? 0) > 0 ? model?.phone : "NA"
        webSiteLabel.text = model?.website ?? "NA"
        companyLabel.text = "\(model?.company?.name ?? " ")\n\(model?.company?.catchPhrase ?? " ")\n\(model?.company?.bs ?? " ")"
        
        
    }
}
