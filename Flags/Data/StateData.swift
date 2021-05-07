//
//  StateData.swift
//  Flags
//
//  Created by jim kardach on 5/6/21.
//
/*
 This struct does most of the work.  It's main function is to crate a struct
 which loads all of its data from a JSON file loaded in the bundle (see the
 "States.json" fle in the navigator).  This file was created by MIT in a civics
 project for here: https://github.com/CivilServiceUSA/us-states.  For the
 the assigmnet we had to list the largest city in the state also, which I
 updated the JSON and added a field for each state for "largest_city".  As it
 had all of this wonderful data, I decided to do all 50 states, but some of
 the data was stale.  url's to some of the state goverment and constitutions
 was bad, so I manually updated these also.
 
 A couple of interesting tricks here.  All of the images are urls, so they are
 downloaded.  Some of these images are very large.  So I've defined the image
 variables are lazy variables so that they are only loaded (from the web) when
 they are used the first time, after that they use the actual png (for lazy
 variables only execute the code the first time they are called).  Then some
 of the images I resize at the same time, as I don't want to load a huge image
 into a small tableview.  So when the first tableview starts, the app can be a
 little hesitent the first time as it is downloading the screen full of images,
 and more as you scroll.  However this is only done the first time, so the
 application speeds up.
 
 The JSON is loaded from the bundle and decoded.  Here I used a bundle extension
 to load the sttes.json data (which I obtained from the hacking with Swift
 Website).
 
 An UIImageView extension for loading an image from a URL is used to load each
 image (which I obtained from the hacking with Swift Website).
 
 Finally I use a UIImage extension to rescale the UIImage downloaded from the
 web (which I obtained from an article Robert Pieta did on how to resize a
 a UIImage without stretching it.

 Otherwise the application is pretty basic.
 
 
 */

import Foundation
import UIKit

struct StateData: Codable {
    let state: String
    let slug: String
    let code: String
    let nickname: String
    let website: String
    let admission_date: String
    let admission_number: Int
    let capital_city: String
    let capital_url: String
    let largest_city: String
    let population: Int
    let population_rank: Int
    let constitution_url: String
    let state_flag_url: String
    let state_seal_url: String
    let map_image_url: String
    let landscape_background_url: String
    let skyline_background_url: String
    
    // the following are lazy vars, so only called once, then return value
    // so urls converted to images only once
    lazy var flag: UIImage? = {
        if let data = try? Data(contentsOf: URL(string: state_flag_url)!) {
            let size = CGSize(width: 75, height: 50)
            let image = UIImage(data: data)!
            return image.scaleImage(size)
        }
        return nil
    }()
    lazy var seal: UIImage? = {
        if let data = try? Data(contentsOf: URL(string: state_seal_url)!) {
            let size = CGSize(width: 50, height: 50)
            let image = UIImage(data: data)!
            
            return image.scaleImage(size)
        }
        return nil
    }()
    lazy var map: UIImage? = {
        if let data = try? Data(contentsOf: URL(string: map_image_url)!) {
            let size = CGSize(width: 75, height: 50)
            let image = UIImage(data: data)!
            return image.scaleImage(size)
        }
        return nil
    }()
    lazy var landscape: UIImage? = {
        if let data = try? Data(contentsOf: URL(string: landscape_background_url)!) {
            return UIImage(data: data)!
        }
        return nil
    }()
    lazy var skyline: UIImage? = {
        if let data = try? Data(contentsOf: URL(string: skyline_background_url)!) {
            let size = CGSize(width: 75, height: 50)
            let image = UIImage(data: data)!
            return image.scaleImage(size)
        }
        return nil
    }()
    
}

// this reads and decodes a JSON file from the bundle
extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIImage {
    func scaleImage(_ targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        return scaledImage
    }
    
}
