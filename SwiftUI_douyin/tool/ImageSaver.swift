//
//  ImageSaver.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/31.
//  Copyright © 2020 ancc. All rights reserved.
//

import UIKit
import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        UIAlertAction(title: "save finished !", style: .cancel) {_ in
            
        }
    }
}
