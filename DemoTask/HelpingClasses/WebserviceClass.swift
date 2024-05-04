//
//  WebserviceClass.swift
//  SafeSeat
//
//  Created by Pankaj on 18/11/22.
//

import UIKit
import Alamofire

class WebserviceClass: NSObject {
    static let shared = WebserviceClass()
    
//    func headersintoApi() -> [String:String]{
//        let accessTokenStr = UserDefaults.standard.value(forKey: Userdegaults.accessToken) as? String ?? ""
//        //string(forKey: "accessToken") ?? ""
//
//        let headers = ["Content-Type":"application/x-www-form-urlencoded",
//                       "Accept":"application/json",
//                       "Authorization":"Bearer " + accessTokenStr]
//        print("HEADERS<<<<<------------",headers)
//        return headers
//    }
    
    func postMethodWithoutHeaderApi(_ params: [String: Any], urlstring: String , completion: @escaping (_ data:[[String:Any]]? , _ error:Error?) -> Void ) {
        if !CheckInternet.Connection(){
           // DisplayBanner.show(message: ErrorMessages.InternetIssue)
            CLProgressHUD.dismiss(animated: true)
            return
        }
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        let Mainurl = urlstring
        manager.request(Mainurl, method:.get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in

            if response.result.isSuccess{
                print("Response Data: \(response)")
                if let data = response.result.value as? [[String:Any]]{
                    completion(data , nil)
                }else{
                    completion(nil,response.error)
                }
                
            }else{
                print("")
                completion(nil,response.error)
                print("Error \(String(describing: response.result.error))")
                
            }
        }
    }
    
}

