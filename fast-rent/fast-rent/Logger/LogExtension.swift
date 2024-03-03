//
//  LogExtension.swift
//  fast-rent
//
//  Created by Yunhao Hu on 2024/3/3.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let fetchingFromFirebase = Logger(subsystem: subsystem, category: "networking")
    static let localStorage = Logger(subsystem: subsystem, category: "localData")
}
