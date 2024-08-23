//
//  IVResultTipView.swift
//  CapturePV
//
//  Created by Hao Liu on 2024/8/22.
//

import UIKit

class IVResultTipView:UIView {
    
    var callBack:callBack = {text in}
    
    var imageS:[String] = [] {
        
        didSet {
            
            setImageLabel()
        }
    }
    
    var VideoS:[String] = [] {
        
        didSet {
            
            setVideoLabel()
        }
    }
    
    lazy var imagesTipBtn:UIButton = {
        
        let sview:UIButton = UIButton()
        sview.setTitleColor(UIColor.black, for: .normal)
        sview.titleLabel?.font = UIFont.systemFont(ofSize: 16.RW(), weight: .medium)
        sview.x = marginLR
        sview.addTarget(self, action: #selector(imagesTipBtnClick), for: .touchUpInside)
        
        return sview
    }()
    
    lazy var videoTipBtn:UIButton = {
        
        let sview:UIButton = UIButton()
        sview.setTitleColor(UIColor.black, for: .normal)
        sview.titleLabel?.font = UIFont.systemFont(ofSize: 16.RW(), weight: .medium)
        sview.addTarget(self, action: #selector(videoTipBtnClick), for: .touchUpInside)
        return sview
    }()
    
    let cWH:CGFloat = 24
    let cWH2:CGFloat = 18
    
    lazy var refreshBtn:UIButton = {
        
        let sview:UIButton = UIButton()
        sview.width = cWH
        sview.height = cWH
        sview.setBackgroundImage(UIImage(named: "refresh"), for: .normal)
        sview.addTarget(self, action: #selector(refreshBtnClick), for: .touchUpInside)
        sview.centerX = width / 2
        sview.centerY = 22
        return sview
    }()
    
    lazy var backBtn:UIButton = {
        
        let sview:UIButton = UIButton()
        sview.width = cWH2
        sview.height = cWH2
        sview.setBackgroundImage(UIImage(named: "back"), for: .normal)
        sview.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        sview.x = refreshBtn.x - cWH - marginLR
        sview.centerY = 22
        return sview
    }()
    
    lazy var fwdhBtn:UIButton = {
        
        let sview:UIButton = UIButton()
        sview.width = cWH2
        sview.height = cWH2
        sview.setBackgroundImage(UIImage(named: "forward"), for: .normal)
        sview.addTarget(self, action: #selector(fwdBtnClick), for: .touchUpInside)
        sview.x = refreshBtn.x + cWH + marginLR
        sview.centerY = 22
        return sview
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        backgroundColor = UIColor.white
    }
    
    func addViews() {
        
        addSubview(imagesTipBtn)
        addSubview(videoTipBtn)
        addSubview(refreshBtn)
        addSubview(backBtn)
        addSubview(fwdhBtn)
    }
    
    func setImageLabel() {
        
        DispatchQueue.main.async {[weak self] in
            guard let self else {return}
            
            self.imagesTipBtn.setTitle("Images(\(imageS.count))", for: .normal)
            self.imagesTipBtn.sizeToFit()
            self.imagesTipBtn.x = marginLR
            self.imagesTipBtn.centerY = 22
        }
        
    }
    
    func setVideoLabel() {
        
        DispatchQueue.main.async {[weak self] in
            guard let self else {return}
            self.videoTipBtn.setTitle("Videos(\(VideoS.count))", for: .normal)
            self.videoTipBtn.sizeToFit()
            self.videoTipBtn.x = width - marginLR - self.videoTipBtn.width
            self.videoTipBtn.centerY = 22
        }
    }
    
    @objc func imagesTipBtnClick() {
        
        callBack("showImages")
    }
    
    @objc func videoTipBtnClick() {
        
        callBack("showVideos")
    }
    
    @objc func refreshBtnClick() {
        
        callBack("refresh")
    }
    
    @objc func backBtnClick() {
        
        callBack("back")
    }
    
    @objc func fwdBtnClick() {
        
        callBack("fwd")
    }
}
