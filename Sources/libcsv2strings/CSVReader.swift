//
//  CSVReader.swift
//  
//
//  Created by Christos Koninis on 9/22/22.
//

import Foundation
import CSVImporter

/// Describes the functionality needed from a CSV reader class.
protocol CSVReader {

    /// Reads a CSV file and returns for each line all the values
    func readCSVAtPath(path: String) -> [[String]]
}

/// Default CSVReader Implementation using CSVImporter library.
final class CSVImporterImpl: CSVReader {

    func readCSVAtPath(path: String) -> [[String]] {
        let importer = CSVImporter<[String]>(path: path, encoding: .utf8)
        return importer.importRecords { $0 }
    }
}
