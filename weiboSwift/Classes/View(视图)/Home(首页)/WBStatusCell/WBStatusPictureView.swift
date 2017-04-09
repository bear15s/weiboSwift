//
//  WBStatusPictureView.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/5.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit

let baseTag:Int = 666
class WBStatusPictureView: UIView {
    
    var statusViewModel:WBStatusViewModel? {
        
        didSet{
         
            
           for i in 0..<9 {
              let imageView = self.viewWithTag(i+baseTag)
              imageView?.isHidden = true
           }
            
            if let originImageArr = statusViewModel?.pic_urls {
//                self.backgroundColor = UIColor.white
                var index = 0
                
                let count = originImageArr.count
                
                for  pictureModel in originImageArr {
                    let imageView = self.viewWithTag(index+baseTag) as! UIImageView
                    imageView.isHidden = false
                    imageView.wb_setImage(urlStr: pictureModel.thumbnail_pic!, placeHoder: "avatar_default_big")
                    
                    //如果是第一张图片, 并且有且只有一张图片, 则让图片等比例显示
                    if index == 0 && originImageArr.count == 1 {
                        imageView.frame = CGRect(origin: CGPoint.zero, size: (statusViewModel?.pictureViewSize)!)
                    }
                        //如果是第一张图片, 但是不止一张图片, 图片的宽高就按照九宫格的正方形大小显示
                    else if index == 0 && originImageArr.count != 1 {
                        let imageWH = (screenWidth - 40) / 3
                        imageView.frame = CGRect(x: 0, y: 0, width: imageWH, height: imageWH)
                    }
                    if count == 4 &&  index == 1{
                        index += 1
//                        imageView.isHidden = true
                    }
                    
                    index += 1
                }
                
            }
            
            if let retweetedImageArr = statusViewModel?.retweetedPic_urls{
                  var index = 0
 
                let count = retweetedImageArr.count
                
                for  pictureModel in retweetedImageArr {
                    let imageView = self.viewWithTag(index+baseTag) as! UIImageView
                    imageView.isHidden = false
                    imageView.wb_setImage(urlStr: pictureModel.thumbnail_pic!, placeHoder: "avatar_default_big")
                    
                    if index == 0 && count == 1 {
                        imageView.frame = CGRect(origin: CGPoint.zero, size: (statusViewModel?.retweetedPictureViewSize)!)
                    }
                        //如果是第一张图片, 但是不止一张图片, 图片的宽高就按照九宫格的正方形大小显示
                    else if index == 0 && count != 1 {
                        let imageWH = (screenWidth - 40) / 3
                        imageView.frame = CGRect(x: 0, y: 0, width: imageWH, height: imageWH)
                    }
                    if count == 4 &&  index == 1{
                        index += 1
//                        imageView.isHidden = true
                    }
                    
                    index += 1
                }
            }
        }
        
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       
       setupUI()
       self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//ui搭建
extension WBStatusPictureView{
    func setupUI(){
        self.clipsToBounds = true
        //1. 创建9个imageView
        let imageWH = (screenWidth - 40)/3
        //移动一次,需要调整的水平或垂直的间隔
        let gap = imageWH + 10
        let firstImageFrame = CGRect(x: 0, y: 0, width: imageWH, height: imageWH)
        for i in 0..<9 {
            let imageView = UIImageView()
            imageView.backgroundColor = UIColor.red
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            addSubview(imageView)
            
            imageView.tag = i + baseTag
            
            //获得行数和列数
            let row = i / 3
            let col = i % 3
            
            //计算每个imageView的frame
            let frame = firstImageFrame.offsetBy(dx: CGFloat(col)*gap, dy: CGFloat(row)*gap)
            
            imageView.frame = frame
            self.addSubview(imageView)
        }
    }
}
