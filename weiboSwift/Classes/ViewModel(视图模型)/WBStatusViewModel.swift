//
//  WBStatusViewModel.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/6.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit

class WBStatusViewModel: NSObject {

    var statusModel:WBStatusModel?
    ///来源
    var sourceString:String?
    ///发表时间
    var createTimeString:String?
    ///皇冠等级
    var vipLevelImage:UIImage?
    ///达人图标
    var vipIconImage:UIImage?
    ///图片数组
    var pic_urls:[WBPictureModel] = []
    ///图片视图大小
    var pictureViewSize:CGSize = CGSize.zero
    
    
    //转发微博
    ///来源
    var retweetedSourceString:String?
    ///发表时间
    var retweetedCreateTimeString:String?
    ///皇冠等级
    var retweetedVipLevelImage:UIImage?
    ///达人图标
    var retweetedVipIconImage:UIImage?
    ///图片数组
    var retweetedPic_urls:[WBPictureModel] = []
    ///图片视图大小
    var retweetedPictureViewSize:CGSize = CGSize.zero
    
    init(statusModel:WBStatusModel){
        self.statusModel = statusModel
        super.init()
        
        dealWithTime()
        dealWithSource()
        dealWithVIPIcon()
        dealWithVIPLevel()
        
        setPicUrlsArray()
        calculatePictureViewSize()
    }
    
    ///处理发表时间
    func dealWithTime() {
        
        if let timeString = statusModel?.created_at {
            createTimeString = Date.requiredTimeStr(sinaTime: timeString)
        }
        
        if let timeString = statusModel?.created_at {
            retweetedCreateTimeString = Date.requiredTimeStr(sinaTime: timeString)
        }
    }
    
    ///处理发表来源
    func dealWithSource(){
        //"<a href=\"http://weibo.com/\" rel=\"nofollow\">iPhone 7 Plus</a>"
        if let source = statusModel?.source {
            
            let startIndex = source.range(of: "\">")?.upperBound
            let endIndex = source.range(of: "</a>")?.lowerBound
            
            let range = startIndex!..<endIndex!
            sourceString = source.substring(with:range)
        }
        
        if let source = statusModel?.retweeted_status?.source {
            
            let startIndex = source.range(of: "\">")?.upperBound
            let endIndex = source.range(of: "</a>")?.lowerBound
            
            let range = startIndex!..<endIndex!
            retweetedSourceString = source.substring(with:range)
        }
    }
    
    ///处理达人图标
    func dealWithVIPIcon(){
        
        if let vip = statusModel?.user?.verified_type{
            //用户vip的信息: 0代表达人, 2, 3, 5代表企业达人, 220代表草根达人
            switch vip {
            case 0:
                vipIconImage = UIImage(named: "avatar_vip")
            case 2,3,5:
                vipIconImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                vipIconImage = UIImage(named: "avatar_grassroot")
            default:
                vipIconImage = nil
            }

        }
        
        if let vip = statusModel?.user?.verified_type{
            //用户vip的信息: 0代表达人, 2, 3, 5代表企业达人, 220代表草根达人
            switch vip {
            case 0:
                retweetedVipIconImage = UIImage(named: "avatar_vip")
            case 2,3,5:
                retweetedVipIconImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                retweetedVipIconImage = UIImage(named: "avatar_grassroot")
            default:
                retweetedVipIconImage = nil
            }
            
        }
    }
    
    ///处理皇冠等级
    func dealWithVIPLevel(){
        
        if let vipLv = statusModel?.user?.mbrank {
            let image = UIImage(named: "common_icon_membership_level\(vipLv)")
            vipLevelImage = image
        }
    }
    
    ///给图片数组赋值
    func setPicUrlsArray(){
        if let originalArr = statusModel?.pic_urls {
            self.pic_urls = originalArr
        }
        
        if let retweetedArr = statusModel?.retweeted_status?.pic_urls {
            self.pic_urls = retweetedArr
        }
    }
    
    ///处理图片
    func calculatePictureViewSize(){
        let imageWH:CGFloat = CGFloat((screenWidth - 20.0)) / 3.0
        //原创微博
        if let originPictures = statusModel?.pic_urls {
            let count = originPictures.count
            if  count > 0 {
                
                let row = (count - 1) / 3 + 1
                let pictureViewWidth = screenWidth - 20
                let pictureViewHeigt = CGFloat(row) * imageWH + 20
                self.pictureViewSize = CGSize(width: pictureViewWidth, height: pictureViewHeigt)
            }
        }
        
        //转发微博
        if let retweetedPictures = statusModel?.retweeted_status?.pic_urls {
            let count = retweetedPictures.count
            if  count > 0 {
                
                let row = (count - 1) / 3 + 1
                let pictureViewWidth = screenWidth - 20
                let pictureViewHeigt = CGFloat(row) * imageWH + 20
                self.pictureViewSize = CGSize(width: pictureViewWidth, height: pictureViewHeigt)
            }
        }
    }
}
