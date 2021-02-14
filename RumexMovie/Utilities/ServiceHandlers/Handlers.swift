//
//  Handlers.swift
//  Created by Sahan Ravindu on 2021-01-29.
//

import Foundation

typealias actionHandler = (_ status: Bool, _ message: String) -> ()
typealias completionHandler = (_ status: Bool, _ code: Int, _ message: String) -> ()
typealias completionHandlerWithData = (_ status: Bool, _ code: Int, _ message: String, _ data: Any?) -> ()
typealias fileDownloadHandler = (_ status: Bool, _ message: String, _ url: String?) -> ()

func delay(_ delay: Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}




