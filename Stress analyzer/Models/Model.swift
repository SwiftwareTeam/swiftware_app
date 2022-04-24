//
//  Model.swift
//  Stress analyzer
//
//  Created by Adrian on 4/13/22.
//

import Foundation
import UIKit
import SwiftUI

struct studentStress {
    var level: Int
    var location: String
    var resp_time: Int
} //don't use this

class resultView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(tableView)
        view.backgroundColor = .systemOrange
    }
}
