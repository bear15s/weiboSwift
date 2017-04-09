//
//  WBStatusToolBar.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/5.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit

class WBStatusToolBar: UIView {
    ///评论
    lazy var retweetBtn:UIButton = UIButton(title: "30", titleColor: UIColor.lightGray, fontSize: 11, image: "timeline_icon_retweet")
    //
    lazy var commentBtn:UIButton = UIButton(title: "30", titleColor: UIColor.lightGray, fontSize: 11, image: "timeline_icon_comment")
    
    lazy var prizeBtn:UIButton = UIButton(title: "30", titleColor: UIColor.lightGray, fontSize: 11, image: "timeline_icon_unlike")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension WBStatusToolBar{
    func setupUI(){
//        self.layer.borderWidth = 0.5
//        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = UIColor(patternImage: UIImage(named: "timeline_card_bottom_background")!)
        self.addSubview(retweetBtn)
        self.addSubview(commentBtn)
        self.addSubview(prizeBtn)
        
        retweetBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        commentBtn.snp.makeConstraints { (make) in
            make.left.equalTo(retweetBtn.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(retweetBtn)
        }
        
        prizeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(commentBtn.snp.right)
            make.right.equalToSuperview()
            make.width.equalTo(commentBtn)
            make.top.bottom.equalToSuperview()
        }
    }
}
