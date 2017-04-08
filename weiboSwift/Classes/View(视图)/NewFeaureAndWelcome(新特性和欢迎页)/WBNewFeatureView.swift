//
//  WBNewFeatureView.swift
//  weiboSwift
//
//  Created by 梁家伟 on 17/4/5.
//  Copyright © 2017年 PipiXia. All rights reserved.
//

import UIKit

class WBNewFeatureView: UIView {

    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: screenBounds)
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    lazy var pageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.black
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: screenBounds)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func setupUI(){
        
        self.addSubview(scrollView)
        self.addSubview(pageControl)
        scrollView.delegate = self
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
        }
        
        setupScrollViewContent()
    }
    
    ///设置scrollView内容
    func setupScrollViewContent(){
        
        for i in 0..<4 {
            
            let imageView = UIImageView(imageName: "new_feature_\(i+1)")
            self.scrollView.addSubview(imageView)
            let width:CGFloat = CGFloat(i) * screenWidth
            imageView.frame = CGRect(x:width, y: 0, width: screenWidth, height: screenHeight)
        }
        self.scrollView.contentSize = CGSize(width: screenWidth * 5, height: screenHeight)
    }
}


extension WBNewFeatureView:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let page = Int(offsetX / screenWidth + 0.5)
        self.pageControl.currentPage = page
        
        if offsetX / screenWidth > 3.4{
            self.removeFromSuperview()
        }
    }
}
