//
//  WBPictureModel.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/5.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit

class WBPictureModel: NSObject {
    /// 微博的图片的缩略图的地址
    var thumbnail_pic: String?
    
    /// 描述信息
    override var description: String {
        return self.yy_modelDescription()
    }
}
