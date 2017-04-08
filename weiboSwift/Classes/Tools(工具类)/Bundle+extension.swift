//
//  Bundlexx.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/5.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit

extension Bundle {
    
    var isNewFeature: Bool {
        //1. 取到当前版本的值
        let newVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        
        //2. 取到老版本的值
        let oldVersion = UserDefaults.standard.value(forKey: versionKey) as? String
        
        //3. 比较
        //如果没有保存过版本号, 或者当前的版本号与老版本不一至, 就明有新版本
        if oldVersion == nil || newVersion != oldVersion! {
            //需要将新版本保存起来
            UserDefaults.standard.setValue(newVersion, forKey: versionKey)
            
            return true
        }
        
        return false
    }
}
