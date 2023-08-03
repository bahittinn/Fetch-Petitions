//
//  Petition.swift
//  Fetch-Petition
//
//  Created by Bahittin on 3.08.2023.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
