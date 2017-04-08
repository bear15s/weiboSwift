//
//  NetworkTool+Loin.swift
//  weiboNine
//
//  Created by HM09 on 17/4/3.
//  Copyright © 2017年 itheima. All rights reserved.
//

import UIKit

extension NetworkTool {
    
    /// 调用该方法来获取code api.weibo.com/oauth2/access_token?client_id
    /// - Parameters:
    ///   - code: 从url中截取的code字符串
    ///   - callBack: 完成回调
    func requestToken(code: String, callBack: @escaping (Any?)->()) {
        let parameters = ["client_id": appKey,
                          "client_secret": appSecrect,
                          "grant_type":"authorization_code",
                          "code":code,
                          "redirect_uri":"http://www.baidu.com"]
        request(url: "https://api.weibo.com/oauth2/access_token", method: "POST", parameters: parameters) { (response) in
            callBack(response)
        }
    }
    
    
    /// 获取用户信息
    ///
    /// - Parameters:
    ///   - uid: 用户的id
    ///   - accessToken: token
    ///   - callBack: 完成回调
    func reqeustUser(uid: String, accessToken: String, callBack: @escaping (Any?)->()) {
        let parameters = ["access_token":accessToken,
                          "uid":uid]
        request(url: "https://api.weibo.com/2/users/show.json", method: "GET", parameters: parameters) { (response) in
            callBack(response)
        }
    }
}
