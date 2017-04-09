//
//  WBHomeController.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/3.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit
import SDWebImage

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
                    
                } else {
                    if responseObj.count > 0 {
                        statusViewModelArr.removeFirst()
                    }
                    self.statusViewModelData += statusViewModelArr
                }
                
                
                self.loadSingleData(viewModels: statusViewModelArr, callBack: { (isSuccess) in
                    if isSuccess {
                        self.tableView.reloadData()
                        
                        //判断是上拉, 还是下拉, 结束菊花转动的状态
                        if isPullDown == true {
                            self.refreshHeader.endRefreshing()
                        } else {
                            self.refreshFooter.endRefreshing()
                        }
                    }
                })
            }
        }
    }
    
    ///下载单张图片
    func loadSingleData(viewModels:[WBStatusViewModel],callBack: @escaping (Bool) -> ()){
        
        
        let group = DispatchGroup()
        for model in viewModels {
            var url:URL?
            if model.pic_urls?.count == 1{
                url = URL(string:(model.pic_urls?[0].thumbnail_pic!)!)!
                group.enter()
                
                SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil) { (singleImage, _, _, _, _) in
                    
                    if let singleImage = singleImage {
                        
                        var imageSize = singleImage.size
                        
                        //如果图片过宽
                        let newWidth = screenWidth - 60
                        if imageSize.width > screenWidth - 20 {
                            //原高/原宽 = 新高/新宽
                            imageSize.height = imageSize.height * newWidth / imageSize.width
                            imageSize.width = newWidth
                        }
//                        print(imageSize)
                        
                        model.pictureViewSize = imageSize
                        
                        group.leave()
                    }
                }
                
            }
            
            if model.retweetedPic_urls?.count == 1{
                url = URL(string:(model.retweetedPic_urls?[0].thumbnail_pic!)!)!
                group.enter()
                SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil) { (singleImage, _, _, _, _) in
                    
                    
                    if let singleImage = singleImage {
                        
                        var imageSize = singleImage.size
                        
                        //如果图片过宽
                        let newWidth = screenWidth - 60
                        if imageSize.width > screenWidth - 20 {
                            //原高/原宽 = 新高/新宽
                            imageSize.height = imageSize.height * newWidth / imageSize.width
                            imageSize.width = newWidth
                        }
//                        print(imageSize)
                        
                        model.retweetedPictureViewSize = imageSize
                        
                        group.leave()
                    }
                }
                
            }
        }
        
        group.notify(queue: DispatchQueue.main){
            callBack(true)
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
