//
//  main.swift
//  JSONHelper
//
//  Created by Justin Hold on 2/7/23.
//

import ArgumentParser
import Foundation

@main
struct App: ParsableCommand {
	
	@Option(name: .shortAndLong, help: "Writes the output to a file instead of standard output.")
	var output: String?
	
	@Flag(name: .shortAndLong, help: "Force overwrite files if they exist already.")
	var forceOverwrite = false
	
	@Flag(name: .shortAndLong, help: "Neatly formats the output.")
	var beautificate = false
	
	@Flag(name: .shortAndLong, help: "Sort keys alphabetically.")
	var sort = false
	
	@Argument(help: "The filename you want to process.")
	var file: String
	
	static var configuration: CommandConfiguration {
		CommandConfiguration(commandName: "jsonHelper", abstract: "Tweaks JSON files to compress or expand data, and provide key sorting.")
	}
	
	func run() {
		
		let url = URL(fileURLWithPath: file)
		
		guard let contents = try? Data(contentsOf: url) else {
			print("Failed to read input file: \(file)")
			return
		}
		
		guard let json = try? JSONSerialization.jsonObject(with: contents, options: .fragmentsAllowed) else {
			print("Failed to prase JSON in input file: \(file)")
			return
		}
		
		var writingOptions: JSONSerialization.WritingOptions = []
		
		if beautificate {
			writingOptions.insert(.prettyPrinted)
		}
		
		if sort {
			writingOptions.insert(.sortedKeys)
		}
		
		do {
			let newData = try JSONSerialization.data(withJSONObject: json, options: writingOptions)
			if let output = output {
				let outputURL = URL(fileURLWithPath: output)
				if FileManager.default.fileExists(atPath: outputURL.path) && forceOverwrite == false {
					print("Cancelling; \(output) exists already.")
				} else {
					try newData.write(to: outputURL)
				}
			} else {
				let outputString = String(decoding: newData, as: UTF8.self)
				print(outputString)
			}
		} catch {
			print("Failed to create JSON output.")
		}
	}
}

