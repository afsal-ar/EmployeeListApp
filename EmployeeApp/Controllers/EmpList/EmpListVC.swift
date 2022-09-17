//
//  EmpListVC.swift
//  EmployeeApp
//
//  Created by InApp on 17/09/22.
//

import UIKit
import SVProgressHUD
import Alamofire
class EmpListVC: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var empModel : [EmployeeModel]? = []
    var empDataArray : [Employee]? = []
    var empDataArrayCpy : [Employee]? = []
    @IBOutlet weak var empListTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        empListTable.delegate = self
        empListTable.dataSource = self
        searchBar.delegate = self
        self.empListTable.register(UINib(nibName: "EmpListTVC", bundle: nil), forCellReuseIdentifier: "empListCell")
        

        getItems()
        // Do any additional setup after loading the view.
    }
    
    func fetchAndStoreEmp(){
        

        
        deleteExistingItems()
        
        
        SVProgressHUD.show()
                // get the default headers
        let headers:HTTPHeaders = [
            "Authorization": "",
            "Content-Type" : ""
        ]
                ParseManager.getEmpDataFromService(urlString: "http://www.mocky.io/v2/5d565297300000680030a986", parameters: nil, httpMethod: .get, headers: headers){
                    (status,response,error,errorStatus,statusTitle,statusMessage) in
                    
                    DispatchQueue.main.async{
        
                                          SVProgressHUD.dismiss()
 
                    }
                    guard status else{
                        print("Error")
                        return
                    }

                    if(response?.count ?? 0 > 0){
                        self.empModel = response ?? []
                        for i in 0..<(self.empModel?.count ?? 0) {
                            self.SaveToDB(model: (self.empModel?[i])!)
                        }
                    }
            }
    }

    
    func SaveToDB(model:EmployeeModel){
        
        let empItem = Employee(context: context)
        let empAddr = Address(context: context)
        let addGeo =  Geo(context: context)
        let empComp = Company(context: context)
        empItem.name = model.name ?? ""
        empItem.phone = model.phone ?? ""
        empItem.username = model.username ?? ""
        empItem.email = model.email ?? ""
        empItem.id = Int64(model.identifier ?? 0)
        empItem.profile_image = model.profile_image ?? ""
        empItem.website = model.website ?? ""
        
        empAddr.city = model.address?.city ?? ""
        empAddr.street = model.address?.street ?? ""
        empAddr.suite = model.address?.suite ?? ""
        empAddr.zipcode = model.address?.zipcode ?? ""
        
        addGeo.lat = model.address?.geo?.lat ?? ""
        addGeo.lng = model.address?.geo?.lng ?? ""
        
        empAddr.geo = addGeo
        empItem.address = empAddr
        
        empComp.name = model.company?.name ?? ""
        empComp.catchPhrase = model.company?.catchPhrase ?? ""
        empComp.bs = model.company?.bs ?? ""
        empItem.company = empComp
        
        do {
            try context.save()
            
            getItems()
        }
        catch {
            
        }
    }
    
    
    func getItems(){
        
        do {
            let items = try context.fetch(Employee.fetchRequest())
            if(items.count > 0){
                empDataArray = items
                empDataArrayCpy = items
                empListTable.reloadData()
             
            }
            else {
                fetchAndStoreEmp()
            }
            
            
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteExistingItems() {
        do {
        let items = try context.fetch(Employee.fetchRequest())
            if(items.count > 0){
        for i in 0...items.count - 1 {
            context.delete(items[i])
        }
            do {
                try context.save()
            }
            catch {
                print(error.localizedDescription)
            }
            }
        }
        catch {
            print(error.localizedDescription)
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
extension EmpListVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empDataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "empListCell", for: indexPath) as? EmpListTVC {
            let model = empDataArray?[indexPath.row]
            cell.setEmpData(model: model)
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newVC = self.storyboard?.instantiateViewController(withIdentifier: "EmpDetailsVCV") as? EmpDetailsVCV {
            newVC.empDetailsModel = empDataArray?[indexPath.row]
            self.navigationController?.pushViewController(newVC, animated: true)
            
        }
    }
    
}
extension EmpListVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let newSearchtext =  searchText.trimmingCharacters(in:.whitespacesAndNewlines)
        empDataArray = empDataArrayCpy?.filter({ (model) -> Bool in
            return (model.name?.lowercased().contains(newSearchtext.lowercased()))! || (model.email?.lowercased().contains(newSearchtext.lowercased()))!
            
            })
            if newSearchtext == "" {
                empDataArray = self.empDataArrayCpy
                
            }
      
            empListTable.reloadData()
    
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
