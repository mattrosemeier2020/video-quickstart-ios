//
//  Utils.swift
//
//  Copyright © 2016-2019 Twilio, Inc. All rights reserved.
//

import Foundation

// Helper to determine if we're running on simulator or device
struct PlatformUtils {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

struct TokenUtils {
    static func fetchToken(url : String) throws -> String {
        var token: String = "TWILIO_ACCESS_TOKEN"
        let requestURL: URL = URL(string: url)!
        do {
            let data = try Data(contentsOf: requestURL)
            guard let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary else { return token }
            
            print(responseDictionary!)
            
            token = responseDictionary!["token"] as? String ?? ""
            
        } catch let error as NSError {
            print ("Invalid token url, error = \(error)")
            throw error
        }
        return token
    }
}
