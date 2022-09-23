//
//  FileWriter.swift
//  
//
//  Created by Christos Koninis on 9/22/22.
//

import Foundation

/// Describes the functionality needed to persistently write data to a file
protocol FileWriter {

    /// Writes String data to a file overiding any previous file if found.
    func saveData(_ stringsFileData: String, toFile path: URL)
}

/// Describes the functionality needed to persistently read data from a file
protocol FileReader {

    /// Reads Text data from a file.
    func readTextFromFile(path: String) throws -> String
}

/// Default implementation of `FileWriter` and `FileReader`
final class PersistenceLayer: FileWriter, FileReader {

    func saveData(_ stringsFileData: String, toFile path: URL) {
        do {
            try stringsFileData.write(to: path, atomically: true, encoding: .utf8)
        }
        catch {
            print("Unexpected error: \(error.localizedDescription)")
        }
    }

    func readTextFromFile(path: String) throws -> String {
        return try String(contentsOfFile: path)
    }
}

