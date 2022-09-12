//
//  PostModel.swift
//  JoyReactor
//
//  Created by Морозов Иван on 03.05.2022.
//

import Foundation

struct PostModel: Identifiable, Equatable {
    let id = UUID()
    var text: String? = nil
    var imageURLs: [String]? = nil
}
