//
//  EmpDetailsVCV.swift
//  EmployeeApp
//
//  Created by InApp on 17/09/22.
//

import UIKit
import SDWebImage
class EmpDetailsVCV: UIViewController {

    @IBOutlet weak var empDetailsTable: UITableView!
    @IBOutlet weak var empImg: UIImageView!
    
    var empDetailsModel : Employee?
    override func viewDidLoad() {
        super.viewDidLoad()
        empDetailsTable.dataSource = self
        self.empDetailsTable.register(UINib(nibName: "EmpDetailsCell", bundle: nil), forCellReuseIdentifier: "empDetailsCell")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setEmpData ()
    }

    
    func setEmpData (){
        
        empImg.sd_setImage(with: URL(string: empDetailsModel?.profile_image ?? ""), placeholderImage:#imageLiteral(resourceName: "placeholder"))
        empDetailsTable.reloadData()
        if (empDetailsTable.contentSize.height < empDetailsTable.frame.size.height) {
            empDetailsTable.isScrollEnabled = false;
         }
        else {
            empDetailsTable.isScrollEnabled = true;
         }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension EmpDetailsVCV : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "empDetailsCell", for: indexPath) as? EmpDetailsCell {
            
            cell.setEmpData(model: empDetailsModel)
            return cell
            
        }
        return UITableViewCell()
    }
    
    
    
}
