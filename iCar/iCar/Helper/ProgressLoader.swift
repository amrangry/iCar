//
//  ProgressLoader.swift
//  XingRepos
//
//  Created by Amr ELghadban on 7/8/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import ARSLineProgress
import UIKit

class ProgressLoader: NSObject {
    static func show() {
        // enable the network indicator on the status bar to indicate to the user that a network process is running
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            ARSLineProgress.show()
        }
    }

    static func dismiss() {
        // invoke the UI update in the main thread and hide the activity indicator to show that the task is completed
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            ARSLineProgress.hide()
        }
    }
}
