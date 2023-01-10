//
//  CommonUtil.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 16/11/2022.
//

import Foundation
import UIKit

class CommonUtil {
    static var SCREEN_WIDTH: CGFloat {
        return (AppDelegate.shared.window?.bounds.width)!
    }
    
    static func getWeekFromDate(_ dateString: String, dateFormat: String = "yyyy-MM-dd") -> String {
        let calendar = Calendar.current
        let date = dateString.toDate()!
        let week = calendar.component(.weekdayOrdinal, from: date)
        return "\(week)"
    }
    
    static func getYearFromDate(_ dateString: String, dateFormat: String = "yyyy-MM-dd") -> String {
        let date = dateString.toDate(dateFormat: dateFormat)
        return "\((date?.get(.year)).isNil(value: 1996))"
    }
    
    static func getMonthFromDate(_ dateString: String, dateFormat: String = "yyyy-MM-dd") -> String {
        let date = dateString.toDate(dateFormat: dateFormat)
        return "\((date?.get(.month)).isNil(value: 12))"
    }
    
    static func getDayFromDate(_ dateString: String, dateFormat: String = "yyyy-MM-dd") -> String {
        let date = dateString.toDate(dateFormat: dateFormat)
        return "\((date?.get(.month)).isNil(value: 28))"
    }

    static func convertNumberMonthToText(_ month: Int) -> String {
        let df = DateFormatter()
        return df.shortMonthSymbols[safe: month - 1].isNil(value: "Null")
    }
    
    static func convertNumberDayToText(_ month: Int) -> String {
        let df = DateFormatter()
        return df.shortWeekdaySymbols[safe: month - 1].isNil(value: "Null")
    }
    
    static func getThumbnailYoutubeUrl(_ key: String) -> URL {
        return URL(string: "https://img.youtube.com/vi/\(key)/maxresdefault.jpg")!
    }
    
    static func saveImageFromPhotosToLocal(info: [UIImagePickerController.InfoKey : Any]) -> String? {
        guard let image = info[.originalImage] as? UIImage else {
            return nil
        }
        let imgData = NSData(data: image.jpegData(compressionQuality: 1)!)
//        let imageSize: Int = imgData.count
//        let sizeMB = Double(imageSize) / (1024.0*1024.0)
        var fileExtention = "jpeg"
        if let imgURL = info[.imageURL] as? URL {
            let subString = imgURL.lastPathComponent.split(separator: ".")
            fileExtention = String(subString[subString.count - 1])
        }
        let fileName = "IMG_\(Int64(Date().timeIntervalSince1970)).\(fileExtention)"
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documents.appendingPathComponent(fileName)
        do {
            try imgData.write(to: url)
        } catch {
            print("Unable to Write Image Data to Disk")
            return nil
        }
        return fileName
    }
    
    static func shareApp(_ viewController: UIViewController, _ view: UIView) {
        let secondActivityItem : NSURL = NSURL(string: "https://apps.apple.com/us/app/id1661605738")!
        
        // If you want to use an image
//                let image : UIImage = UIImage(named: "Black_adam")!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [secondActivityItem], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = view
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 300, height: view.frame.height)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
        UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = false
        viewController.present(activityViewController, animated: true, completion: nil)
    }
}

public func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
