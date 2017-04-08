//
//  WBLoginController.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/4.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit

class WBLoginController: UIViewController {

    lazy var webView:UIWebView? = {
        let webView = UIWebView(frame: self.view.bounds)
        webView.delegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView!)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(backToPreviousVC))
        
        loadLoginData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadLoginData(){
        
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectURI)"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        self.webView?.loadRequest(request)
    }
    
}

//交互
extension WBLoginController{
    
    func backToPreviousVC(){
        self.dismiss()
    }
    
    
    func dismiss(){
        dismiss(animated: true, completion: nil)
    }
}

//MASK: -webView代理
extension WBLoginController:UIWebViewDelegate{
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        //1. 判断url是否是回调页, 如果是回调页, 页面不能显示出来, return false
        if let urlString = request.url?.absoluteString,
            urlString.hasPrefix(redirectURI) == true,
            let query = request.url?.query {
            //2. 判断点击的是取消还是授权按钮: 如果参数的的前缀是 'code=', 说明点击是授权按钮
            if (query.hasPrefix("code=")) {
                //3. 获取token
                //拦截url地址:  http://www.baidu.com/?code=0d822614e628ed858c780b4634af6a64, 获取code
                //a.获取到"code="子串的range, range是一个index的区间值(lowerBound..<upperBound), upperBound取的是区间值的右边的index的值; lowerBounds可以取到械的index的值
                let subrange = urlString.range(of: "code=")
                //b.截取字符串, 获取code
                let code = urlString.substring(from: (subrange?.upperBound)!)
                
                //4. 使用code获取token
                NetworkTool.shared.requestToken(code: code, callBack: { (tokenDic) in
                    //判断token是否获取到
                    if let tokenDic = tokenDic as? [String: Any],
                        let uid = tokenDic["uid"] as? String,
                        let token = tokenDic["access_token"] as? String {
                        
                        //5. 获到到token之后, 顺手获取一下用户信息
                        NetworkTool.shared.reqeustUser(uid: uid, accessToken: token, callBack: { (userDic) in
                            //判断userDic是否有值
                            if var userDic = userDic as? [String: Any] {
                                //6. 合并字典
                                for (k, v) in tokenDic {
                                    userDic[k] = v
                                }
                                
                                //7. 保存用户信息
                                WBUserAccount.shared.save(dict: userDic)
                                
                                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue:loginNotificationName)))
                                
                                self.dismiss()
                            } else {
                                //没有成功获取到user信息
                                self.dismiss()
                            }
                        })
                    } else {
                        //没有成功获取到token
                        self.dismiss()
                    }
                })
            } else { //点击的是取消按钮
                self.dismiss()
            }
            
            return false
        }
        
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let javascriptStr =  "document.getElementById('userId').value='\(wbuserName)';document.getElementById('passwd').value='\(wbPassword)'"
        webView.stringByEvaluatingJavaScript(from:javascriptStr)
    }
}
