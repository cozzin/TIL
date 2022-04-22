//
//  InputGenerator.swift
//  InputGenerator
//
//  Created by Ernest Hong on 2022/03/06.
//
//  Command Line App 참고: https://www.avanderlee.com/swift/command-line-tool-package-manager/

import Foundation
import ArgumentParser

struct InputGenerator: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Generate a random numbers text file from the given input")

    @Argument(help: "Max digits of integer.")
    private var maxDigits: Int
    
    @Argument(help: "The number of integers to print.")
    private var numberOfIntegers: Int

    func run() throws {
        let integers: [Int] = uniqueRandomNumbers(min: 0, max: numberOfIntegers * 10, count: numberOfIntegers)
        let output = integers.map(String.init).joined(separator: "\n")
        let filePath = FileManager.default.currentDirectoryPath.appending("RandomIntegers-maxDigits\(maxDigits)-integers\(numberOfIntegers).txt")
        
        do {
            try output.write(toFile: filePath, atomically: true, encoding: .utf8)
            print("Success: RandomIntegers.txt is generated in \(filePath)")
        } catch {
            print("Failure: \(error)")
        }
    }
    
    // https://stackoverflow.com/a/65761682
    private func uniqueRandomNumbers(min: Int, max: Int, count: Int) -> [Int] {
        var result: Set<Int> = []
        while result.count < count {
            result.insert(.random(in: min..<max))
        }
        return Array(result)
    }

}

InputGenerator.main()
