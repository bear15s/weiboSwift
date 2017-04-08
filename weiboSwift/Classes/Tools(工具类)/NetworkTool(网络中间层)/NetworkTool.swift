//
//  NetworkTool.swift
//  AFN网络中间层
//
//  Created by HM09 on 17/4/3.
//  Copyright © 2017年 itheima. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTool: AFHTTPSessionManager {
    /// swift中单例的写法
    //static let shared = NetworkTool()
    
    //单例, 创建时设置其可接受的格式
    static let shared: NetworkTool = {
        let tool = NetworkTool(baseURL: nil)
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tool
    }()
    
    /// 网络中间层
    ///
    /// - Parameters:
    ///   - url: url字符串
    ///   - method: 请求方式
    ///   - parameters: 参数
    ///   - callBack: 完成回调的闭包
    func request(url: String, method: String, parameters: Any?, callBack: @escaping (Any?)->()) {
        //发起get请求
        if method == "GET" {
            self.get(url, parameters: parameters, progress: nil, success: { (_, responseObject) in
                callBack(responseObject)
            }, failure: { (_, error) in
                print(error)
                callBack(nil)
            })
        }
        
        //发起post请求
        if method == "POST" {
            self.post(url, parameters: parameters, progress: nil, success: { (_, responseObject) in
                callBack(responseObject)
            }, failure: { (_, error) in
                print(error)
                callBack(nil)
            })
        }
    }
}
