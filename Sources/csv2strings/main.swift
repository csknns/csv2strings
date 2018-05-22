//import CSV
import Foundation
import CSVImporter

let arguments = CommandLine.arguments

let group = DispatchGroup()

if arguments.count != 2 {
    print("USAGE: \(arguments[0]) <csv file>")
} else {
    let cvsFile = arguments[1]
    let stringsFileURL = URL(fileURLWithPath: cvsFile).deletingPathExtension().appendingPathExtension("strings")

    print("reading form \(cvsFile)")

    let importer = CSVImporter<[String]>(path: cvsFile)
    let importedRecords = importer.importRecords { $0 }

    var stringsFileData : String = ""
    for record in importedRecords {
        stringsFileData.append("\"\(record[0])\" = \"\(record[1])\";\n")
    }

    print("writing \(importedRecords.count) translations to \(stringsFileURL)")
    // write strings file
    do {
        try stringsFileData.write(to: stringsFileURL, atomically: true, encoding: .utf16)
    }
    catch {
        print("Unexpected error: \(error).")
    }
}
