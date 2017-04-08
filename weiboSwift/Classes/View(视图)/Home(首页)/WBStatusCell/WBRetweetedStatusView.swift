//
//  WBRetweetedStatusView.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/5.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit
import SDWebImage

class WBRetweetedStatusView: UIView {

    var statusViewModel:WBStatusViewModel?{
        didSet{
            //设置头像
            if let urlString = statusViewModel?.statusModel?.user?.avatar_large{
                let url = URL(string: urlString)!
                SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _, _) in
                    image?.createCircleImage(color: UIColor(white: 0.9, alpha: 1),size: CGSize(width: 32, height: 32), callBack: { (circleImage) in
                        self.iconView.image = circleImage
                    })
                })
            }
            //用户昵称
            userNameLabel.text = statusViewModel?.statusModel?.retweeted_status?.user?.screen_name
            //发表时间
            createTimeLabel.text = statusViewModel?.retweetedCreateTimeString
            //皇冠等级
            vipLevelImageView.image = statusViewModel?.retweetedVipLevelImage
            //达人图标
            vipIcon.image = statusViewModel?.retweetedVipIconImage
            //发布来源
            sourceLabel.text = statusViewModel?.retweetedSourceString
            //微博正文
            retweetedStatusLabel.text = statusViewModel?.statusModel?.retweeted_status?.text
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
    lazy var retweetedStatusLabel:UILabel = UILabel(title: "微博正文,微博正文微博正文微博正文微博正文微博正文微博正文")
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

extension WBRetweetedStatusView{
    fileprivate func setupUI(){
        self.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.addSubview(iconView)
        self.addSubview(vipIcon)
        self.addSubview(userNameLabel)
        self.addSubview(vipLevelImageView)
        self.addSubview(createTimeLabel)
        self.addSubview(sourceLabel)
        self.addSubview(retweetedStatusLabel)
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
        retweetedStatusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
//            make.bottom.equalToSuperview().offset(-10)
        }
        
        //多图
        pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(retweetedStatusLabel.snp.bottom).offset(10)
            make.height.equalTo(200)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
