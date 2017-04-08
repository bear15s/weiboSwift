//
//  WBVisitorView.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/3.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit

protocol WBVisitorViewDelegate:NSObjectProtocol{
    func login()
}

class WBVisitorView: UIView {
//    "visitorInfo" : {
//    "imageName" : "visitordiscover_feed_image_house",
//    "message" : "关注一些人，回这里看看有什么惊喜",
//    "isAnimation" : true
//    }
    weak var delegate:WBVisitorViewDelegate?
    
    var visitorInfo:[String:Any]?{
        didSet{
            if let message = visitorInfo?["message"] as? String{
                
                self.messageLabel.text = message
            }
            
            if let imageName = visitorInfo?["imageName"] as? String{
                self.iconImageView.image = UIImage(named:imageName)
            }
            
            
            if let _ = visitorInfo?["isAnimation"] as? Bool{
                self.circleImageView.isHidden = false
            }else{
                self.circleImageView.isHidden = true
            }
        }
    }
    
    //房子图片
    lazy var iconImageView:UIImageView = UIImageView(imageName: "visitordiscover_feed_image_house")
    //圈圈图片
    lazy var circleImageView:UIImageView = UIImageView(imageName: "visitordiscover_feed_image_smallicon")
    //渐变背景
    lazy var maskImageView:UIImageView = UIImageView(imageName: "visitordiscover_feed_mask_smallicon")
    //文字
    lazy var messageLabel:UILabel = UILabel(title: "关注一些人，回这里看看有什么惊喜", textColor:UIColor.lightGray,fontSize:16, numOfLines: 0, alignment: .center)
//    //注册按钮
    lazy var registerBtn:UIButton = UIButton(title: "注册", titleColor: .orange, image:nil , bgImage:"common_button_white_disable", target: self, action: #selector(buttonClick(button:)), event: .touchUpInside)
    //登录按钮
    lazy var loginBtn:UIButton = UIButton(title: "登录", titleColor: .darkGray, image: nil, bgImage: "common_button_white_disable", target: self, action: #selector(buttonClick(button:)), event: .touchUpInside)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

//MASK: -交互
extension WBVisitorView{
    
    func buttonClick(button:UIButton){
        self.delegate?.login()
    }
}



//MASK: -设置UI
extension WBVisitorView{
    
    func setupUI(){
        
        self.addSubview(maskImageView)
        self.addSubview(iconImageView)
        self.addSubview(circleImageView)
        self.addSubview(messageLabel)
        self.addSubview(registerBtn)
        self.addSubview(loginBtn)
        
        //maskImage
        self.maskImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        //图片
        self.iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
        }
        
        //圈圈
        self.circleImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImageView)
            make.centerX.equalToSuperview()
        }
        
        //文字
        self.messageLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.centerY.equalToSuperview().offset(70)
        }
        
        //注册按钮
        self.registerBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(-100)
            make.size.equalTo(CGSize(width: 80, height: 32))
        }
        
        //登录按钮
        self.loginBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-50)
            make.bottom.equalTo(registerBtn)
            make.size.equalTo(CGSize(width: 80, height: 32))
        }
        
        setCAAnimation()
    }
    
    //设置圈圈旋转
    func setCAAnimation(){
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue =  2 * M_PI
        animation.duration = 6
        animation.isRemovedOnCompletion = false
        animation.repeatCount = MAXFLOAT
        self.circleImageView.layer.add(animation, forKey: "circleAnimation")
    }
    
}

