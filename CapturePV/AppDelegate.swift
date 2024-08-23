//
//  AppDelegate.swift
//  CapturePV
//
//  Created by Hao Liu on 2024/8/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setConfig()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = ViewController()
        
        window?.rootViewController = vc
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func setConfig() {
        
        startNetStatus()
        getDefaulHeight()
    }
    
    func startNetStatus() {
        
        NetStatusManager.manager.startNet { status in
            
            
        }
            
    }
    
    func getDefaulHeight() {
        
        if #available(iOS 13.0, *) {
            
            let window = UIApplication.shared.windows.first
            let topPadding = window?.safeAreaInsets.top ?? 0
            statusBarHeight = topPadding > 0 ? topPadding:20
            navHeight = navDefaultHeight + statusBarHeight
            navCenterY = 22 + statusBarHeight
        }else {
            
            statusBarHeight = UIApplication.shared.statusBarFrame.size.height
            navHeight = navDefaultHeight + statusBarHeight
            navCenterY = 22 + statusBarHeight
        }
        
        if #available(iOS 11.0, *) {
            
            safeHeight = UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
        
        }else {
            
            safeHeight = 0
        }
    }

}

