//
//  WBStatusModel.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/5.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit
import YYModel

class WBStatusModel: NSObject {
    /// 微博发布时间
    var created_at: String?
    /// 微博的id
    var id: Int = 0
    /// 微博的来源
    var source: String?
    /// 微博的正文
    var text: String?
    /// 微博的图片
    var pic_urls: [WBPictureModel]? //在yymodel中被定义为容器类属性
    /// 发微博的用户
    var user: WBUserModel?
    /// 转发微博的数据
    var retweeted_status: WBStatusModel?
    /// 描述属性
    override var description: String{
        return self.yy_modelDescription()
    }
    ///
    class func modelContainerPropertyGenericClass() -> [String:Any]{
        return ["pic_urls":WBPictureModel.self]
    }

}
