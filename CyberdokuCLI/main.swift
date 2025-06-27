//
//  main.swift
//  CyberdokuCLI
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

let arguments = CommandLine.arguments
guard arguments.count >= 3 else {
    print("Usage: CyberdokuCLI <inputTemplatePath> <outputCSVPath>")
    exit(1)
}

let inputTemplatePath = arguments[1]
let outputCSVPath = arguments[2]
let outputURL = URL(fileURLWithPath: outputCSVPath)

do {
    let inputURL = URL(fileURLWithPath: inputTemplatePath)

    try TrainingDataGenerator.generateTrainingData(from: inputURL, outputURL: outputURL)
    print("Training data written to \(outputCSVPath)")
} catch {
    print("Failed to generate training data: \(error)")
    exit(1)
}

