//
//  CommonFunc.swift
//  CapturePV
//
//  Created by Hao Liu on 2024/8/22.
//

import AVFoundation
import UIKit

func generateThumbnail(from url: URL, completion: @escaping (UIImage?) -> Void) {
    DispatchQueue.global().async {
        let asset = AVAsset(url: url)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImageGenerator.appliesPreferredTrackTransform = true
        
        // 生成封面图的时间点，可以选择视频的任意时间点
//        let time = CMTime(seconds: 1.0, preferredTimescale: 600)
        
        let time = CMTime(value: 0, timescale: 1)
        
        do {
            let cgImage = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            let image = UIImage(cgImage: cgImage)
            DispatchQueue.main.async {
                completion(image)
            }
        } catch {
            print("Error generating thumbnail: \(error.localizedDescription)")
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
}
