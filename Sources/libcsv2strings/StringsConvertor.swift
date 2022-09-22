import Foundation
import CSVImporter
import os.log

final public class StringsConvertor {
    public init() {}

    public func toStringsFile(_ csvFile: String) {
        let stringsFileURL = URL(fileURLWithPath: csvFile).deletingPathExtension().appendingPathExtension("strings")

        print("reading form \(csvFile)")

        let importer = CSVImporter<[String]>(path: csvFile, encoding: .utf8)
        let importedRecords = importer.importRecords { $0 }

        var stringsFileData : String = ""
        for record in importedRecords {
            var commentLine = record[2]
            if !commentLine.isEmpty {
                // drop the first and last quotes if needed
                // they are added to escape delimiters etc.
                if commentLine.first == "\"" && commentLine.last == "\"" {
                    commentLine = String(String(commentLine.dropFirst()).dropLast())
                }
                // Append an extra empty new line between records
                commentLine = "\(commentLine)\n"
            }

            stringsFileData.append("\(commentLine)\"\(record[0])\" = \"\(record[1])\";\n\n")
        }

        print("writing \(importedRecords.count) translations to \(stringsFileURL)")
        do {
            try stringsFileData.write(to: stringsFileURL, atomically: true, encoding: .utf8)
        }
        catch {
            print("Unexpected error: \(error.localizedDescription)")
        }
    }

    public func toCSVFile(_ stringsFile: String) {
        let csvFileURL = URL(fileURLWithPath: stringsFile).deletingPathExtension().appendingPathExtension("csv")
        let delimiter = ","

        print("reading form \(stringsFile)")

        guard let contents = try? String(contentsOfFile: stringsFile) else {
            print("could not read any data")
            return
        }

        var stringsFileData : String = ""
        let quotedString =
    """
    "([^"]+)"
    """
        let equalsAndWhiteSpace =
    """
    \\s*=\\s*
    """
        let comments =
    """
    (/\\*([^*]|[\\r\\n]|(\\*+([^*/]|[\\r\\n])))*\\*+/|//.*\\n?)
    """
        var previousComment = ""
        var lineCounter = 0
        for line in contents.components(separatedBy: CharacterSet.newlines).map({ $0.trimmingCharacters(in: .whitespaces) }) {
            lineCounter += 1
            if let commentRange = line.range(of: "\(comments)", options: .regularExpression) {
                var comment = String(line[commentRange])
                comment = "\"\(comment)\""
                if previousComment != "" {
                    print("found comment '\(comment)' at line \(lineCounter) without a translation")
                }
                previousComment = comment
            }
            else if let keyRange = line.range(of: "\(quotedString)", options: .regularExpression) {
                let key = line[keyRange]

                if line.range(of: "\(equalsAndWhiteSpace)", options: .regularExpression, range: keyRange.upperBound..<line.endIndex) != nil {
                    if let valueRange = line.range(of: "\(quotedString)", options: .regularExpression, range: keyRange.upperBound..<line.endIndex) {
                        let value = line[valueRange]
                        stringsFileData.append("\(key)\(delimiter)\(value)\(delimiter)\(previousComment)\n")
                    } else {
                        print("not translation found for '\((key))' at line \(lineCounter) ")
                        stringsFileData.append("\(key)\(delimiter)\(delimiter)\(previousComment)\n")
                    }
                }
                previousComment = ""
            } else if !line.isBlank {
                print("skipping '\(line)' at line \(lineCounter) ")
            }
        }

        print("writing to \(csvFileURL)")

        do {
            try stringsFileData.write(to: csvFileURL, atomically: true, encoding: .utf8)
        }
        catch {
            print("Unexpected error: \(error.localizedDescription)")
        }
    }

}
