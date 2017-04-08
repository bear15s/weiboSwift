//
//  WBRootViewController.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/2.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit
import MJRefresh

fileprivate let identifier = "cellIdentifier"
class WBRootController: UIViewController {
    var vistorView:WBVisitorView?
    var visitorDict:[String:Any]?
    
    ///下拉刷新菊花
    lazy var refreshHeader:MJRefreshNormalHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
    ///上拉刷新菊花
    lazy var refreshFooter:MJRefreshAutoNormalFooter = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadData))
    ///模型数组
    
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: screenBounds, style: .plain)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        return tableView
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: Notification.Name(rawValue:loginNotificationName), object: nil)
    }
    
    func loadData(){
        print("loadData")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//设置ui
extension WBRootController{
    
    func setupUI(){
        self.view.backgroundColor = UIColor.rgbColor(r: 237, g: 237, b: 237)
    
        
        if  !(WBUserAccount.shared.isLogin){
            setupVistorView()
            vistorView?.delegate = self
        }
        setupTableView()
    }
    
    func setupVistorView(){
        vistorView = WBVisitorView(frame: self.view.bounds)
        self.view.addSubview(vistorView!)
        vistorView?.visitorInfo = self.visitorDict
    }
    
    func setupTableView(){
        self.view.addSubview(tableView)
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(11)
            make.bottom.equalTo(self.view)
        }
        
        setupRefreshControl()
    }
    
    //设置刷新控件
    func setupRefreshControl(){
        self.tableView.tableHeaderView = self.refreshHeader
        self.tableView.tableFooterView = self.refreshFooter
    }
}


//MASK: -tableView  datasource代理
extension WBRootController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
}


//MASK: -事件处理
extension WBRootController{
    func loginSuccess(){
        vistorView?.removeFromSuperview()
        vistorView = nil
    }
}

//MASK: -访客视图代理
extension WBRootController:WBVisitorViewDelegate {
    func login() {
        let loginVC = WBLoginController()
        let nav = UINavigationController(rootViewController: loginVC)
        self.present(nav, animated: true, completion: nil)
    }
}



