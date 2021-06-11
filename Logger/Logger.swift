//
//  Logger.swift
//  Logger
//
//  Created by 60067671 on 2021/06/11.
//

import Foundation
import os

class CustomLogger {
	/*
	error: 오류를 일으킨 문제에 관한 메시지
	warning: 아직 오류는 아니지만 발생할 수 있는 문제에 관한 메시지
	info: 정보용 로그 메시지
	debug: 개발 단계에서만 유용한 디버그 로그 메시지
	verbose: 기본 로그 메시지(기본)
	*/

	// MARK: - 선택된 type에 해당하는 로그를 출력
	private static func makeLogString(description: String, tag: Any?, message: Any) -> String {

		//		let dateFormatter = DateFormatter()
		//		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
		//		dateFormatter.timeZone = TimeZone.autoupdatingCurrent
		//		dateFormatter.locale = Locale.current
		//		let timestamp = dateFormatter.string(from: Date.init()) // 시간이 console에 나오기 때문에 로그에 추가 안함, 필요시 추가
		let thread = Thread.current.isMainThread ? "main": Thread.current.name ?? "-" // 현재 스레드

		if let tag = tag {
			return "\n" + description + "[Thread: \(thread)] [Tag: \(tag)]\n>>> \(message)\n<<<\n"
		} else {
			return "\n" + description + "[Thread: \(thread)] \n>>>\n\(message)\n<<<\n"
		}
	}

	static func error(fileName: String = #file, lineNumber: Int = #line, functionName: String = #function, tag: Any?, message: Any) {
		var description: String = "[‼️] \(sourceFileName(filePath: fileName)) [Line: \(lineNumber)] \(functionName) "

		description = self.makeLogString(description: description, tag: tag, message: message)
		if #available(iOS 14.0, *) {
			let logger = Logger()
			logger.error("\(description)")
		} else if #available(iOS 10.0, *) {
			os_log("%@", type: .error, description)
		} else {
			print(description)
		}
		fatalError(description)
	}

	static func warning(fileName: String = #file, lineNumber: Int = #line, functionName: String = #function, tag: Any?, message: Any) {
		var description: String = "[⚠️] \(sourceFileName(filePath: fileName)) [Line: \(lineNumber)] \(functionName) "

		description = self.makeLogString(description: description, tag: tag, message: message)
		if #available(iOS 14.0, *) {
			let logger = Logger()
			logger.warning("\(description)")
		} else if #available(iOS 10.0, *) {
			os_log("%@", type: OSLogType.default, description)
		} else {
			print(description)
		}
	}

	static func info(fileName: String = #file, lineNumber: Int = #line, functionName: String = #function, tag: Any?, message: Any) {
		var description: String = "[ℹ️] \(sourceFileName(filePath: fileName)) [Line: \(lineNumber)] \(functionName) "

		description = self.makeLogString(description: description, tag: tag, message: message)
		if #available(iOS 14.0, *) {
			let logger = Logger()
			logger.info("\(description)")
		} else if #available(iOS 10.0, *) {
			os_log("%@", type: .info, description)
		} else {
			print(description)
		}
	}

	static func debug(fileName: String = #file, lineNumber: Int = #line, functionName: String = #function, tag: Any?, message: Any) {
		var description: String = "[🐛] \(sourceFileName(filePath: fileName)) [Line: \(lineNumber)] \(functionName) "

		description = self.makeLogString(description: description, tag: tag, message: message)
		if #available(iOS 14.0, *) {
			let logger = Logger()
			logger.log("\(description)")
		} else if #available(iOS 10.0, *) {
			os_log("%@", type: .default, description)
		} else {
			print(description)
		}
	}

	static func verbose(fileName: String = #file, lineNumber: Int = #line, functionName: String = #function, tag: Any?, message: Any) {
		var description: String = "[💬] \(sourceFileName(filePath: fileName)) [Line: \(lineNumber)] \(functionName) "

		description = self.makeLogString(description: description, tag: tag, message: message)
		if #available(iOS 14.0, *) {
			let logger = Logger()
			logger.log("\(description)")
		} else if #available(iOS 10.0, *) {
			os_log("%@", type: .default, description)
		} else {
			print(description)
		}
	}

	private static func sourceFileName(filePath: String) -> String {
		let components = filePath.components(separatedBy: "/")
		return components.isEmpty ? "" : components.last!
	}

	private static func convertToString(_ string: Any?) -> String {
		if let string = string as? String {
			return string
		} else {
			return ""
		}
	}
}
