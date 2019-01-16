//
//  UIImage+Utility.swift
//  Seat
//
//  Created by Gary Dos Santos on 25/8/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit

public enum DegradateOrientation {
    
    case horizontal, vertical
    
}

extension UIImage {
    
    /// Create a degradate image from the given colors
    /// - parameters:
    ///     - bounds : the bounds size to create the degradate
    ///     - from : the color to start the degradate
    ///     - to : the color to finish the degradate
    ///     - orientation : to create the degradate, horizontal(left to right), vertical(top to bottom)
    /// - returns: a UIImage with the wanted degradate
    public static func degradate(bounds: CGRect, from: UIColor, to: UIColor, orientation: DegradateOrientation ) -> UIImage {
        let gradientLayer = CAGradientLayer()
        if orientation == .horizontal {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        }
        gradientLayer.colors = [from.cgColor, to.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = bounds
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, gradientLayer.isOpaque, 0.0)
        if let currentContext = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: currentContext)
        }
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
    
    /// Transform a UIImage to a String with Base64 format
    /// - parameters:
    ///     - width : the size of the image to transform
    ///     - compression : the compression need it of the image
    /// - returns: the string that conttains the image in format Base64
    public func toBase64(width: CGFloat, compression: CGFloat) -> String {
        var image = self
        if self.size.width > width, let newImage = resizeWithWidth(width: width) {
            image = newImage
        }
        if let imageData = UIImageJPEGRepresentation(image, compression) {
            let base64String = "\(imageData.base64EncodedString(options: .lineLength64Characters))"
            return base64String
        }
        return ""
    }
    
    /// Resize the image with the size of the width
    /// - parameters:
    ///     - width : the size to be resized the image
    /// - returns: a image resized with the given width
    public func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    /// Resize the image with the size given
    /// - parameters:
    ///     - targetSize : the size to be resized the image
    /// - returns: a image resized with the given size
    public func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0.0, y: 0.0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    
    /// Add a mask color to a image
    /// - parameters:
    ///     - color : to create the mask
    /// - returns: a image with a mask with the given color
    public func addMask(color: UIColor) -> UIImage {
        guard let maskImage = cgImage else { return self }
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            return UIImage(cgImage: cgImage)
        } else {
            return self
        }
    }
    
    /// Tint the image with the given color. The image needs to be a pdf file
    /// - parameters:
    ///     - color : to tint the image
    /// - returns: a image with the given color
    public func tint(withColor color: UIColor) -> UIImage {
        return modifiedImage { context, rect in
            // draw tint color
            context.setBlendMode(.normal)
            color.setFill()
            context.fill(rect)
            
            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(self.cgImage!, in: rect)
        }
    }
    
    /// Create a image from a solid color
    /// - parameters:
    ///     - color : to create image
    ///     - size  : the size of the image, default is CGSize(width: 1, height: 1)
    public static func imageFromColor(withColor color: UIColor, withSize size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    /// Return the image for a given imageName and dictionary with options
    /// - parameters:
    ///     - imageName : The name of the fiven image.
    /// - returns: UIImage
    public static func imageWithImageName(_ imageName:String) -> UIImage {
        guard let image = UIImage(named: imageName) else {
            return UIImage()
        }
        
        return image
    }
    
    private func modifiedImage(draw: (CGContext, CGRect) -> ()) -> UIImage {
        // using scale correctly preserves retina images
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        
        // correctly rotate image
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        draw(context, rect)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return image
        } else {
            return UIImage()
        }
    }
    
}
