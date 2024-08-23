//
//  ShouVideoResultViewController.swift
//  CapturePV
//
//  Created by Hao Liu on 2024/8/22.
//

import UIKit
import SDWebImage

class ShouVideoResultViewController:UIViewController {
    
    var resultArray:[String] = []
    
    lazy var tableView:UITableView = {
        
        let cY:CGFloat = navHeight
        
        let sview:UITableView = UITableView.init(frame: CGRectMake(0, cY, view.width, ScreenH - cY))
        sview.backgroundColor = .clear
        sview.separatorStyle = .none
        sview.showsVerticalScrollIndicator = false
        sview.delegate = self
        sview.dataSource = self
        sview.register(ShouVideoResultCell.self, forCellReuseIdentifier: ShouVideoResultCell.identifier)
        sview.contentInset = UIEdgeInsets(top: marginLR, left: 0, bottom: 0, right: 0)
        if #available(iOS 15.0, *) {
            
            sview.sectionHeaderTopPadding = 0
        }
        
        return sview
    }()
    
    init(resultArray:[String]) {
        
        self.resultArray = resultArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.colorWithHex(hexStr: whiteColor)
        
        addViews()
    }
    
    func addViews() {
        
        self.view.addSubview(tableView)
    }
}

extension ShouVideoResultViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ShouVideoResultCell = tableView.dequeueReusableCell(withIdentifier: ShouVideoResultCell.identifier, for: indexPath) as! ShouVideoResultCell
        
        if indexPath.row < resultArray.count {
            
            cell.model = resultArray[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       return 300
    }
    
}

class ShouVideoResultCell:UITableViewCell {
    
    static let identifier:String = "ShouVideoResultCellID"
    
    let cellHeight:CGFloat = 300
    
    lazy var backView:UIView = {
        
        let backView:UIView = UIView()
        backView.backgroundColor = UIColor.colorWithHex(hexStr: cellBackColor)
        backView.width = ScreenW
        backView.x = 0
        return backView
    }()
    
    lazy var iconImage:UIImageView = {
        
       let iconImage:UIImageView = UIImageView()
        
        iconImage.width = ScreenW - 2 * marginLR

        iconImage.x = marginLR
        iconImage.y = marginLR
        
        iconImage.contentMode = .scaleAspectFill
        iconImage.clipsToBounds = true
        return iconImage
    }()
    
    lazy var urlLabel:UILabel = {
        
        let sview:UILabel = UILabel()
        sview.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        sview.textColor = UIColor.colorWithHex(hexStr: "#666666")
        return sview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        addSubview1()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        backgroundColor = UIColor.colorWithHex(hexStr: whiteColor)
        selectionStyle = .none
    }
    
    func addSubview1() {
        
        contentView.addSubview(iconImage)
        contentView.addSubview(urlLabel)
    }
    
    var model:String = "" {
        
        didSet {
            
            urlLabel.text = model
            urlLabel.sizeToFit()
            urlLabel.width = ScreenW - 2 * marginLR
            urlLabel.x = marginLR
            urlLabel.y = cellHeight - marginLR - urlLabel.height
            
            iconImage.height = urlLabel.y - 2 * marginLR
            iconImage.cornerCut(radius: 12, corner: .allCorners)
            
            
            guard let url = URL(string: model) else {return}
            
//            self.iconImage.sd_setImage(with: url) { image, error, type, url in
//                
//                
//
//            }
            
            generateThumbnail(from: url) {[weak self] image in
                
                guard let self ,let image = image else {return}
                
                self.iconImage.image = image
            }
        }
    }
}

