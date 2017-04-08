//
//  WBHomeController.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/3.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit


fileprivate let identifier = "homeCell"

class WBHomeController: WBRootController {
    
    var statusViewModelData:[WBStatusViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(WBStatusCell.self, forCellReuseIdentifier: identifier)
        setupRefreshControl()
        if WBUserAccount.shared.isLogin {
            loadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MASK: -加载数据
    override func loadData(){
        
        var since_id:Int = 0
        var max_id:Int = 0
        
        var isPullDown = true
        if refreshFooter.isRefreshing() {
            isPullDown = false
            max_id = statusViewModelData.last?.statusModel?.id ?? 0
        } else {
            since_id = statusViewModelData.first?.statusModel?.id ?? 0
        }
        
        NetworkTool.shared.requestStatus(since_id: since_id,max_id:max_id) { (responseObj) in
            if let responseObj = responseObj as? [WBStatusModel]{
                
                var statusViewModelArr = [WBStatusViewModel]()
                
                for statusModel in responseObj {
                    let viewModel = WBStatusViewModel(statusModel: statusModel)
                    statusViewModelArr.append(viewModel)
                }
                
                if isPullDown == true {
                    
                    self.statusViewModelData = self.statusViewModelData + statusViewModelArr
                    self.refreshHeader.endRefreshing()
                    
                } else {
                    if responseObj.count > 0 {
                        statusViewModelArr.removeFirst()
                    }
                    self.statusViewModelData += statusViewModelArr
                    self.refreshFooter.endRefreshing()
                }
                
                self.tableView.reloadData()
            }
        }
    }
}

//MASK: -数据相关
extension WBHomeController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusViewModelData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = statusViewModelData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!WBStatusCell
        cell.statusViewModel = model
        return cell
    }
}
