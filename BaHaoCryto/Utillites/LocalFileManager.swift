//
//  LocalFileManager.swift
//  BaHaoCryto
//
//  Created by nguyenbahao on 26/12/2022.
//
// quan li tep
import Foundation
import SwiftUI
class LocalFileManager{
    static let instance = LocalFileManager()
    private init(){}
    
    func saveImage(image: UIImage, imageName: String, folderName: String){
        //tao folder
        createFolderifNeeded(folderName: folderName)
        //lấy đường dẫn cho image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else{return}
        //save image to path(duong dan)
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image.\(imageName) \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String)-> UIImage?{
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else{
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    //Tao folder neu can
    private func createFolderifNeeded(folderName: String){
        guard let url = getURLForFoder(folderName: folderName) else {return}
        
        if !FileManager.default.fileExists(atPath: url.path){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory. FolderName:\(folderName).\(error)")
            }
        }
    }
    private func getURLForFoder(folderName: String) -> URL?{
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
            return nil
        }
        return url.appendingPathExtension(folderName)
    }
    private func getURLForImage(imageName: String, folderName: String)-> URL? {
        guard let forderURL = getURLForFoder(folderName: folderName) else {return nil}
        return forderURL.appendingPathExtension(imageName)
    }
    
}
