//
//  StateData.swift
//  Flags
//
//  Created by jim kardach on 5/6/21.
//

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
            return UIImage(data: data)!
        }
        return nil
    }()
    lazy var seal: UIImage? = {
        if let data = try? Data(contentsOf: URL(string: state_seal_url)!) {
            return UIImage(data: data)!
        }
        return nil
    }()
    lazy var map: UIImage? = {
        if let data = try? Data(contentsOf: URL(string: map_image_url)!) {
            return UIImage(data: data)!
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
            return UIImage(data: data)!
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
