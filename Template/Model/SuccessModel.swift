//
//  SuccessModel.swift
//  KasunSandeepBitzean
//
//  Created by Kasun Sandeep on 11/2/20.
//

import UIKit

struct SuccessModel: Codable {
    var status:Int
    var message:String
    
    enum CodingKeys: String, CodingKey {
        case status = "api_status"
        case message
    }
}
