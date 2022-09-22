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

/// Default implementation of `FileWriter`
final class FileWriterImpl: FileWriter {

    func saveData(_ stringsFileData: String, toFile path: URL) {
        do {
            try stringsFileData.write(to: path, atomically: true, encoding: .utf8)
        }
        catch {
            print("Unexpected error: \(error.localizedDescription)")
        }
    }
}

