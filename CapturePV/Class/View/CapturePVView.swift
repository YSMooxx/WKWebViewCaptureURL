//
//  CapturePVView.swift
//  CapturePV
//
//  Created by Hao Liu on 2024/8/22.
//

import UIKit
import WebKit

class CapturePVView:UIView {
    
    private let URL_define = "URL"
    private let canGoBackKeyPath = "canGoBack"
    
    lazy var textView:UITextField = {
        
        let searchHeight:CGFloat = 44.RW()
        
        let sview:UITextField = UITextField(frame: CGRect(x: marginLR, y:navHeight, width:ScreenW - 2 * marginLR , height: searchHeight))
        sview.centerY = navCenterY
        sview.backgroundColor = UIColor.colorWithHex(hexStr: "#383838")
        sview.textColor = UIColor.colorWithHex(hexStr: whiteColor)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.colorWithHex(hexStr: "#666666"), // 设置你想要的颜色
            .font: UIFont.systemFont(ofSize: 14.RW()) // 你也可以设置字体等其他属性
        ]
        
        sview.attributedPlaceholder = NSAttributedString(string: "Please Write Url", attributes: attributes)
        
        let leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: marginLR, height: searchHeight))
        leftView.backgroundColor = sview.backgroundColor
        sview.leftView = leftView
        sview.leftViewMode = .always
        sview.textAlignment = .left
        sview.tintColor = UIColor.colorWithHex(hexStr: mColor)
        sview.font = UIFont.systemFont(ofSize: 14)
        sview.textColor = UIColor.colorWithHex(hexStr: whiteColor)
        sview.returnKeyType = .done
        sview.delegate = self
        
        sview.cornerCut(radius: 12.RW(), corner: .allCorners)
        
        
        return sview
    }()
    
    lazy var webView: WKWebView = {
        
        let webConfiguration = WKWebViewConfiguration()
        
        let cY:CGFloat = textView.y + textView.height + marginLR
        
        let webView1:WKWebView = WKWebView(frame:CGRect(x: 0, y: cY, width: ScreenW, height: ScreenH - cY - 44 - safeHeight ),configuration: webConfiguration)
        webView1.allowsLinkPreview = false
        webView1.scrollView.backgroundColor = .white
        webView1.allowsBackForwardNavigationGestures = true
        webView1.backgroundColor = .white
        webView1.uiDelegate = self
        webView1.navigationDelegate = self
        webView1.scrollView.delegate = self
        
        if #available(iOS 11.0, *) {
            
            webView1.scrollView.contentInsetAdjustmentBehavior = .never
        }
        
       return webView1
    }()
    
    lazy var resultTipView:IVResultTipView = {
        
        let sview:IVResultTipView = IVResultTipView(frame: CGRect(x: 0, y: webView.y + webView.height, width: ScreenW, height: 44 + safeHeight))
        
        sview.callBack = {[weak self] (text) in
            guard let self else {return}
            
            if text == "refresh" {
                
                self.webView.reload()
            }else if text == "back" {
                
                self.webView.goBack()
            }else if text == "goForward" {
                
                self.webView.goForward()
            }else if text == "showImages" {
                
                let vc:ShouImageResultViewController = ShouImageResultViewController(resultArray: self.resultTipView.imageS)
                
                self.responderViewController()?.present(vc, animated: true)
            }else if text == "showVideos" {
                
                let vc:ShouVideoResultViewController = ShouVideoResultViewController(resultArray: self.resultTipView.VideoS)
                
                self.responderViewController()?.present(vc, animated: true)
            }
        }
        
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
        
        backgroundColor = .white
        
        webView.addObserver(self, forKeyPath: canGoBackKeyPath, options: .new, context: nil)
        webView.addObserver(self, forKeyPath: URL_define,options: .new, context: nil)
    }
    
    func addViews() {
        
        addSubview(textView)
        addSubview(webView)
        addSubview(resultTipView)
    }
    
    func LoadWithUrl(url:String) {
        
        if url.count == 0 {
            
            return
        }
        
        let newUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let URL1 = URL(string:newUrl) else { return }
        
        let request = URLRequest(url: URL1)
        
        webView.load(request)
    }
    
    open override func observeValue(forKeyPath keyPath: String?,of object:Any?,change: [NSKeyValueChangeKey: Any]?,context:UnsafeMutableRawPointer?) {
        
        guard let theKeyPath = keyPath, object as? WKWebView == webView else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        if theKeyPath == canGoBackKeyPath{
            
//            if let newValue = change?[NSKeyValueChangeKey.newKey],  let newV = newValue as? Bool{
//               
//            }
        }else if theKeyPath == URL_define{
            
            getImageVideo()
        }
    }
    
    
    func getImageVideo() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {[weak self]  in
            
            guard let self else {return}
            
            self.webView.evaluateJavaScript(allImage) {[weak self] (result, error) in
                
                guard let self else {return}
                guard let array = result as? [String] else { return }
                
                var resultStr:[String] = []
                
                for imageStr in array {
                    
                    print("imageUrl-----------\(imageStr)")
                    
                    if imageStr.containsSubstring(substring: "https://") || imageStr.containsSubstring(substring: "http://") {
                        
                        if imageStr.containsSubstring(substring: "png") || imageStr.containsSubstring(substring: "jpg") || imageStr.containsSubstring(substring: "jepg") {
                            
                            resultStr.append(imageStr)
                        }
                        
                    }
                }
                
                self.resultTipView.imageS = resultStr
                
            }
            
            self.webView.evaluateJavaScript(allVideo) {[weak self] (result, error) in
                
                guard let self else {return}
                guard let array = result as? [String] else { return }
                
                var resultStr:[String] = []
                
                for imageStr in array {
                    
                    print("videoUrl-----------\(imageStr)")
                    
                    if imageStr.containsSubstring(substring: "https://") || imageStr.containsSubstring(substring: "http://") {
                        
                        resultStr.append(imageStr)
                    }
                }
                
                self.resultTipView.VideoS = resultStr
            }
        })
        
    }
    
    func scrollViewDidEnd(contentOffsetX: CGFloat) {
        
        getImageVideo()
    }
    
    deinit {
        
        webView.removeObserver(self, forKeyPath: canGoBackKeyPath, context: nil)
        webView.removeObserver(self, forKeyPath: URL_define, context: nil)
    }
}

extension CapturePVView:WKUIDelegate,WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        getImageVideo()
//        startTimer()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
}

extension CapturePVView:WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
            if message.name == "imageUrls", let imageUrls = message.body as? [String] {
                print("Image URLs: \(imageUrls)")
                // 你可以在这里处理图片 URL，比如下载或展示图片
            } else if message.name == "videoUrls", let videoUrls = message.body as? [String] {
                print("Video URLs: \(videoUrls)")
                // 你可以在这里处理视频 URL，比如下载或播放视频
            }
        }
}

extension CapturePVView:UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let scroend:Bool = (scrollView.isTracking) || (scrollView.isDragging) || (scrollView.isDecelerating)
        
        if scroend == false {
            
            let x:CGFloat = scrollView.contentOffset.y
            scrollViewDidEnd(contentOffsetX: x)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
//        let scroend:Bool = (scrollView.isTracking) || (scrollView.isDragging) || (scrollView.isDecelerating)
//        
//        if scroend == false {
//            
//            let x:CGFloat = scrollView.contentOffset.y
//            
//        }
        
        scrollViewDidEnd(contentOffsetX: x)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let scroend:Bool = (scrollView.isTracking) || (scrollView.isDragging) || (scrollView.isDecelerating)
        
        if scroend == false {
            
            let x:CGFloat = scrollView.contentOffset.y
            scrollViewDidEnd(contentOffsetX: x)
        }
    }
}


extension CapturePVView:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        var text:String = textField.text ?? ""
        
        if text.contains("https://") || text.contains("http://") {
            
            
        }else {
            
            text = "https://" + text
        }
        
        self.LoadWithUrl(url: text)
        
        textField.resignFirstResponder()
        
        return true
    }
}
