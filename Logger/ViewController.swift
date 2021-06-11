//
//  ViewController.swift
//  Logger
//
//  Created by Jongho Lee on 2021/06/11.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		CustomLogger.warning(tag: nil, message: "warning 로그")
		CustomLogger.info(tag: nil, message: "info 로그")
		//		CustomLogger.error(tag: nil, message: "error 로그")
		CustomLogger.debug(tag: nil, message: "debug 로그")
		CustomLogger.verbose(tag: nil, message: "verbose 로그")
	}
}

