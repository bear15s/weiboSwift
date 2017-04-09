//
//  UIImageView+extension.swift
//  weiboNine
//
//  Created by HM09 on 17/4/2.
//  Copyright © 2017年 itheima. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(imageName: String) {
        self.init()
        let image = UIImage(named: imageName)
        self.image = image
    }

    /// 封装网络加载图片的中间层
    ///
    /// - Parameters:
    ///   - urlStr: 图片的url字符串
    ///   - placeHoder: 占位图片名字
    func wb_setImage(urlStr: String, placeHoder: String) {
        let url = URL(string: urlStr)
        let pimage = UIImage(named: placeHoder)
        
        if let url = url, let pimage = pimage{
            self.sd_setImage(with: url, placeholderImage: pimage)
        }
    }
}
