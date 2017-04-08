//
//  WBdate.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/6.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit

let dateFormat = DateFormatter()
let calendar = Calendar.current

extension Date{

    /// 传入新浪服务器返回的时间字符串, 直接返回需求的时间字符串
    static func requiredTimeStr(sinaTime: String) -> String {
        let date = Date.sinaTimeToDate(sinaTime: sinaTime)
        return date.dateToRequiredTimeStr()
    }
    
    /// 1. 新新浪服务器返回的时间字符串转成Date对象
    //Date在swift是一个结构体, 在结构中, 类方法(静态方法)用static来修饰
    static func sinaTimeToDate(sinaTime: String) -> Date {
        
        let formatStr = "EEE MMM dd HH:mm:ss zzz yyyy"
        dateFormat.locale = Locale(identifier: "en")
        dateFormat.dateFormat = formatStr
        
        return dateFormat.date(from: sinaTime)!
    }
    
    /// 2. 将Date对象转成app需要的时间格式的字符串
    func dateToRequiredTimeStr() -> String {
        let seconds: Int64 = Int64(Date().timeIntervalSince(self))
        //print(seconds)
        
        //判断是否是一分钟以内
        if seconds < 60 {
            return "刚刚"
        }
        
        //大于一分钟, 小于1小时
        if seconds < 3600 {
            return "\(seconds/60)分钟前"
        }
        
        //大于一小时, 小于1天
        if seconds < 3600 * 24 {
            return "\(seconds/3600)小时前"
        }
        
        //判断是否是昨天: 昨天 05: 05
        var formatStr = ""
        if calendar.isDateInYesterday(self) {
            formatStr = "昨天 HH:mm"
        } else {
            //判断是否是今年, 比昨天更早: `03-15 05: 05`
            //通过calendar取到时间元素
            let dateYear = calendar.component(.year, from: self) //self也就是新浪数据的时间年份
            let thisYear = calendar.component(.year, from: Date()) //当前时间的年份
            
            //今年
            if dateYear == thisYear {
                formatStr = "MM-dd HH:mm"
            }
                //往年
            else{
                formatStr = "yyyy-MM-dd HH:mm"
            }
        }
        
        dateFormat.locale = Locale(identifier: "en")
        dateFormat.dateFormat = formatStr
        
        return dateFormat.string(from: self)
    }
    
}
