//
//  WBOriginalStatusView.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/5.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit
import SDWebImage

class WBOriginalStatusView: UIView {

    var statusViewModel:WBStatusViewModel?{
        didSet{
            
            
            pictureView.statusViewModel = statusViewModel
            
            
            //设置头像
            if let urlString = statusViewModel?.statusModel?.user?.avatar_large{
                let url = URL(string: urlString)!
                SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _, _) in
                    image?.createCircleImage(size: CGSize(width: 32, height: 32), callBack: { (circleImage) in
                        self.iconView.image = circleImage
                    })
                })
            }
            
            if let originArr = statusViewModel?.pic_urls,originArr.count > 0 && statusViewModel?.statusModel?.retweeted_status == nil{
                
                pictureView.snp.updateConstraints { (make) in
                    make.top.equalTo(statusLabel.snp.bottom).offset(10)
                    make.left.equalToSuperview().offset(10)
                    make.bottom.equalToSuperview().offset(-10)
                    make.size.equalTo((statusViewModel?.pictureViewSize)!)
                }
            }
            else {
                pictureView.snp.updateConstraints { (make) in
                    make.top.equalTo(statusLabel.snp.bottom)
                    make.left.equalToSuperview().offset(10)
                    make.bottom.equalToSuperview().offset(-10)
                    make.size.equalTo(CGSize.zero)
                }
            }
           
            
            //用户昵称
            userNameLabel.text = statusViewModel?.statusModel?.user?.screen_name
            //发表时间
            createTimeLabel.text = statusViewModel?.createTimeString
            //皇冠等级
            vipLevelImageView.image = statusViewModel?.vipLevelImage
            //达人图标
            vipIcon.image = statusViewModel?.vipIconImage
            //发布来源
            sourceLabel.text = statusViewModel?.sourceString
            //微博正文
            statusLabel.text = statusViewModel?.statusModel?.text
        }
    }
    
    
    ///用户的头像
    lazy var iconView:UIImageView = UIImageView(imageName: "avatar_default_big")
    ///用户的vip图标
    lazy var vipIcon:UIImageView = UIImageView(imageName: "avatar_grassroot")
    ///用户的昵称
    lazy var userNameLabel:UILabel = UILabel(title: "隔壁老王",fontSize:13, alignment: .center)
    ///用户的vip等级
    lazy var vipLevelImageView:UIImageView = UIImageView(imageName: "common_icon_membership_level1")
    ///微博的来源
    lazy var sourceLabel:UILabel = UILabel(title: "iPhone6S", textColor: UIColor.lightGray,fontSize:13,alignment: .center)
    ///微博的发布时间
    lazy var createTimeLabel:UILabel = UILabel(title: "5分钟前",textColor: UIColor.lightGray,fontSize:13,alignment: .center)
    ///微博的正文的label
    lazy var statusLabel:UILabel = UILabel(title: "微博正文,微博正文微博正文微博正文微博正文微博正文微博正文")
    ///多图视图
    lazy var pictureView:WBStatusPictureView = WBStatusPictureView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension WBOriginalStatusView{
    fileprivate func setupUI(){
      
        self.addSubview(iconView)
        self.addSubview(vipIcon)
        self.addSubview(userNameLabel)
        self.addSubview(vipLevelImageView)
        self.addSubview(createTimeLabel)
        self.addSubview(sourceLabel)
        self.addSubview(statusLabel)
        self.addSubview(pictureView)
        
        //头像
        iconView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 36, height: 36))
        }
        
        //vip图标
        vipIcon.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(-12)
            make.top.equalTo(iconView.snp.bottom).offset(-12)
        }
        
        //用户名
        userNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.top.equalTo(iconView)
        }
        
        //vip等级
        vipLevelImageView.snp.makeConstraints { (make) in
            make.left.equalTo(userNameLabel.snp.right).offset(10)
            make.top.equalTo(userNameLabel)
        }
        
        //发布时间
        createTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userNameLabel)
            make.top.equalTo(userNameLabel.snp.bottom).offset(4)
        }
        
        //来源
        sourceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(createTimeLabel)
            make.left.equalTo(createTimeLabel.snp.right).offset(10)
        }
        
        //正文
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
//            make.bottom.equalToSuperview().offset(-10)
        }
        
        //多图
        pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(statusLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize.zero)
        }
    }
}
