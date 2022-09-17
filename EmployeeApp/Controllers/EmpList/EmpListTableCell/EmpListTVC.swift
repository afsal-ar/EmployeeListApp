//
//  EmpListTVC.swift
//  EmployeeApp
//
//  Created by InApp on 17/09/22.
//

import UIKit
import SDWebImage
class EmpListTVC: UITableViewCell {

    @IBOutlet weak var empEmail: UILabel!
    @IBOutlet weak var empImg: UIImageView!
    @IBOutlet weak var empName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setEmpData(model : Employee?){
        
        empName.text = model?.name ?? ""
        empEmail.text = model?.email ?? ""
        empImg.sd_setImage(with: URL(string: model?.profile_image ?? ""), placeholderImage:#imageLiteral(resourceName: "placeholder"))
    }
}
