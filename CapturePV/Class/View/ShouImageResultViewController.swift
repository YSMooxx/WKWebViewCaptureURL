//
//  ShouResultViewController.swift
//  CapturePV
//
//  Created by Hao Liu on 2024/8/22.
//

import UIKit
import SDWebImage

class ShouImageResultViewController:UIViewController {
    
    var resultArray:[String] = []
    
    lazy var tableView:UITableView = {
        
        let cY:CGFloat = navHeight
        
        let sview:UITableView = UITableView.init(frame: CGRectMake(0, cY, view.width, ScreenH - cY))
        sview.backgroundColor = .clear
        sview.separatorStyle = .none
        sview.showsVerticalScrollIndicator = false
        sview.delegate = self
        sview.dataSource = self
        sview.register(ShouResultCell.self, forCellReuseIdentifier: ShouResultCell.identifier)
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

extension ShouImageResultViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ShouResultCell = tableView.dequeueReusableCell(withIdentifier: ShouResultCell.identifier, for: indexPath) as! ShouResultCell
        
        if indexPath.row < resultArray.count {
            
            cell.model = resultArray[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       return 300
    }
    
}

class ShouResultCell:UITableViewCell {
    
    static let identifier:String = "ShouResultCellID"
    
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
        
//        contentView.addSubview(backView)
//        backView.addSubview(iconImage)
//        backView.addSubview(<#T##view: UIView##UIView#>)
        
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
            self.iconImage.sd_setImage(with: url, placeholderImage: UIImage(), context: nil)
        }
    }
}
