
//
//  NetworkTool+status.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/5.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit
import YYModel

extension NetworkTool{

    func requestStatus(since_id:Int = 0,max_id:Int = 0,callBack: @escaping (Any?)->()){
        let parameters:[String : Any] = [
             "access_token":WBUserAccount.shared.access_token!,
             "since_id":since_id,
             "max_id":max_id]
        request(url: "https://api.weibo.com/2/statuses/home_timeline.json", method: "GET", parameters: parameters) { (response) in
            if let response = response as? [String:Any],let statusDictArr = response["statuses"] as? [[String:Any]]{
             
                if let modelArr = NSArray.yy_modelArray(with: WBStatusModel.self, json: statusDictArr){
                    
                    callBack(modelArr)
                    
                }else{
                    callBack(nil)
                }
            }
        }
    }
    
}
