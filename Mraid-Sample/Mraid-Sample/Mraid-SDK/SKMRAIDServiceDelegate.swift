//
//  SKMRAIDServiceDelegate.swift
//  SwiftProject
//
//  Created by dev on 18/04/18.
//  Copyright © 2018 hexims. All rights reserved.
//

import UIKit


struct Constants {
    static let MRAIDSupportsSMS = "TEST"
    //static let MRAIDSupportsCalendar = "calendar"
    static let MRAIDSupportsStorePicture = "storePicture"
    static let MRAIDSupportsInlineVideo = "inlineVideo"

}
protocol SKMRAIDServiceDelegate: NSObjectProtocol
{
    func mraidServiceOpenBrowserWithUrlString(urlString: NSString)
    func mraidServiceStorePictureWithUrlString(urlString: NSString)
}
