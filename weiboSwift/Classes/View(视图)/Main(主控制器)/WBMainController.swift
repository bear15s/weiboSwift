//
//  WBMainController.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/2.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit

class WBMainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: -ui设置
extension WBMainController{
    
    ///设置ui
    func setupUI(){
        
        addChildControllers()
        
        setupShadowImage()
        
        setupComposeButton()
        
        setupNewFeatureView()
    }
    
    func setupNewFeatureView(){
        
        let isNewFeature = Bundle.main.isNewFeature
        
        if WBUserAccount.shared.isLogin == true {
            if isNewFeature {
                
                let newFeatureView = WBNewFeatureView()
                self.view.addSubview(newFeatureView)
                newFeatureView.snp.makeConstraints({ (make) in
                    make.edges.equalToSuperview()
                })
            }else{
                
            }
        }
    }
    
    func setupShadowImage(){
        self.tabBar.backgroundImage = UIImage(named:"tabbar_background")
        self.tabBar.shadowImage = UIImage.pureImage(color: UIColor.init(white: 0.9, alpha: 0.8), size: CGSize(width: self.view.bounds.width, height: 1))
    }
    
    //添加子控制器
    func addChildControllers(){
        let url:URL = Bundle.main.url(forResource: "main.json", withExtension: nil)!
        if let data:Data = try? Data.init(contentsOf: url),
        let dictArr = try? JSONSerialization.jsonObject(with: data, options: []){
            
            let dictArr = dictArr as! [[String:Any]]
            
            var controllers = [UINavigationController]()
            
            for dict in dictArr {
                
                controllers.append(addNavigationVC(dict: dict)!)
            }
            
            self.viewControllers = controllers
        }
    }
    
    ///实例化导航控制器
    func addNavigationVC(dict:[String:Any]) -> UINavigationController?{
        
        let vcName = "weiboSwift" + "." + (dict["clsName"] as! String)
        
        if let cls = NSClassFromString(vcName){
            let cls = cls as! WBRootController.Type
            //创建类
            let vc = cls.init()
            
            vc.title = dict["title"] as? String
            
            if let imageName = dict["imageName"] as? String{
            vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)?.withRenderingMode(.alwaysOriginal)
            vc.tabBarItem.selectedImage = UIImage(named:"tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
            }
            
            vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .selected)
            
            let nav = UINavigationController.init(rootViewController: vc)
            
            if let visitorDict = dict["visitorInfo"] as? [String:Any]{
                vc.visitorDict = visitorDict
            }
            
            
            return nav
        }
        
        return nil
    }
    
    ///添加发布按钮
    func setupComposeButton(){
        
        let composeBtn = UIButton(title: nil,image: "tabbar_compose_icon_add", bgImage: "tabbar_compose_button", target: self, action: #selector(compose(button:)), event: .touchUpInside)
        
        let width = self.view.bounds.width / 5
        
        composeBtn.frame = self.tabBar.bounds.insetBy(dx: width*2 - 2, dy: 8)
        
        self.tabBar.addSubview(composeBtn)
        
    }
}

//交互
extension WBMainController{
    
    func compose(button:UIButton){
        print("发布微博")
    }
}
