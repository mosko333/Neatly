////
////  UIImageExtensions.swift
////  Stuffy
////
////  Created by John Hancock on 7/20/18.
////  Copyright © 2018 Adam Moskovich. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//extension UIImage {
//    func fixedOrientation() -> UIImage {
//        
//        var transform: CGAffineTransform = CGAffineTransform.identity
//        
//        switch imageOrientation {
//        case UIImage.Orientation.down, UIImage.Orientation.downMirrored:
//            transform = transform.translatedBy(x: size.width, y: size.height)
//            transform = transform.rotated(by: CGFloat(Double.pi))
//            break
//        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored:
//            transform = transform.translatedBy(x: size.width, y: 0)
//            transform = transform.rotated(by: CGFloat(Double.pi / 2))
//            break
//        case UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
//            transform = transform.translatedBy(x: 0, y: size.height)
//            transform = transform.rotated(by: CGFloat(Double.pi / 2))
//            break
//        case UIImage.Orientation.up, UIImage.Orientation.upMirrored:
//            break
//        }
//        switch imageOrientation {
//        case UIImage.Orientation.upMirrored, UIImage.Orientation.downMirrored:
//            transform.translatedBy(x: size.width, y: 0)
//            transform.scaledBy(x: -1, y: 1)
//            break
//        case UIImage.Orientation.leftMirrored, UIImage.Orientation.rightMirrored:
//            transform.translatedBy(x: size.height, y: 0)
//            transform.scaledBy(x: -1, y: 1)
//        case UIImage.Orientation.up, UIImage.Orientation.down, UIImage.Orientation.left, UIImage.Orientation.right:
//            break
//        }
//        
//        let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
//        
//        ctx.concatenate(transform)
//        
//        switch imageOrientation {
//        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored, UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
//            ctx.draw(self.cgImage!, in: CGRect(origin: CGPoint.zero, size: size))
//        default:
//            ctx.draw(self.cgImage!, in: CGRect(origin: CGPoint.zero, size: size))
//            break
//        }
//        
//        let cgImage: CGImage = ctx.makeImage()!
//        
//        return UIImage(cgImage: cgImage, scale: 1, orientation: .right)
//    }
//}
