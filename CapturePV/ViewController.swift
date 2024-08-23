//
//  ViewController.swift
//  CapturePV
//
//  Created by Hao Liu on 2024/8/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var captureView:CapturePVView = {
        
        let sview:CapturePVView = CapturePVView(frame: view.bounds)
        
        return sview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addViews()
        
//    https://www.douyin.com/
//    https://www.dailymotion.com/
//    https://www.youtube.com/
//    http://www.baidu.com/
//    https://ldyt.online/
//    https://m.weibo.cn/
        captureView.LoadWithUrl(url: "https://www.youtube.com/")
    }

    func addViews() {
        
        view.addSubview(captureView)
    }
}

