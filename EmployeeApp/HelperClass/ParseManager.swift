//
//  ParseManager.swift
//  EmployeeApp
//
//  Created by InApp on 17/09/22.
//

import UIKit
import Alamofire
class ParseManager: NSObject {
    class func getDataFromService(urlString:String?,parameters:AnyObject?,httpMethod:HTTPMethod,headers: HTTPHeaders,completion:@escaping (Bool,Data?,Error?,Int?) -> Void) {
        AF.request(
            URL(string: urlString ?? "")!,
            method: httpMethod,
            parameters: parameters as? Parameters ?? nil,
            headers:headers)
            .validate()
            .responseJSON { (response) -> Void in
                if(response.value != nil){
                    completion(true,response.data ,response.error, response.response?.statusCode)
                }
                    else {
                    completion(false,response.data ,response.error, response.response?.statusCode)
                    }
        }
    }
    
   class func getEmpDataFromService(urlString:String?,parameters:AnyObject?,httpMethod:HTTPMethod,headers:HTTPHeaders, completionHandler: @escaping (Bool,[EmployeeModel]?,Error?,Int?,String?,String?)->Void){
        getDataFromService(urlString: urlString, parameters: parameters, httpMethod: httpMethod,headers: headers) {
            (success,result,error,errorStatus) in
            guard success else{
            completionHandler(false,nil,error,errorStatus,"Failed","Some error occured. Please try again later.")
            return
            }
            guard let resultData = result else{
            completionHandler(false,nil,error,errorStatus,"Failed","Some error occured. Please try again later.")
            return
            }
            
                var empModelObj : [EmployeeModel] = []
                let jsonDecoder = JSONDecoder()
                do {
                    let obj = try jsonDecoder.decode([EmployeeModel].self, from: resultData)
                    empModelObj = obj
                }
                catch {
                    completionHandler(false,nil,error,errorStatus,"Failed","Some error occured. Please try again later.")
                }

            completionHandler(true,empModelObj,nil,nil,"Success","fetched successfully.")
        }
    }
}
