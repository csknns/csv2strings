import Foundation

///
///  Converts to and from Apple's strings files and CSV files with comma delimiter.
///
///   The resulting CSV file will have 3 columns like this:
///  ```
///     "translation key","translated message","/* developer comments */"
///  ```
///  Developer comments are always quoted because we need to escape the comma "," and/or double quotes ".
///  The output files will be in UTF-8 encoding.
final public class StringsConvertor {
    private let CSVReader: CSVReader
    private let fileWriter: FileWriter
    private let fileReader: FileReader

    init(CSVReader: CSVReader, fileWriter: FileWriter, fileReader: FileReader) {
        self.CSVReader = CSVReader
        self.fileWriter = fileWriter
        self.fileReader = fileReader
    }

    public convenience init() {
        let persistenceLayer = PersistenceLayer()
        self.init(CSVReader: CSVImporterImpl(), fileWriter: persistenceLayer, fileReader: persistenceLayer)
    }

    public func toStringsFile(_ csvFile: String) {
        let stringsFileURL = URL(fileURLWithPath: csvFile).deletingPathExtension().appendingPathExtension("strings")

        print("reading form \(csvFile)")

        let importedRecords = CSVReader.readCSVAtPath(path: csvFile)

        var stringsFileData : String = ""
        for record in importedRecords {
            if record.count != 3 { continue }
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

        fileWriter.saveData(stringsFileData, toFile: stringsFileURL)
    }

    public func toCSVFile(_ stringsFile: String) {
        let csvFileURL = URL(fileURLWithPath: stringsFile).deletingPathExtension().appendingPathExtension("csv")

        guard let contents = StringsFileParser(stringsFilePath: stringsFile, fileReader: fileReader)?.parse() else {
            print("unable to parse \(stringsFile)")
            return
        }

        let csvLines = contents.entries.map(makeCSVLine)
        let stringsFileData = "\(csvLines.joined(separator: "\n"))\n"

        print("writing \(csvLines.count) translations to \(csvFileURL)")

        fileWriter.saveData(stringsFileData, toFile: csvFileURL)
    }

    private func makeCSVLine(from entry: StringsFile.Translation) -> String {
        let delimiter = ","
        return "\(entry.translationKey)\(delimiter)\(entry.translation)\(delimiter)\(entry.comment ?? "")"
    }
}

/// Top level model of a Apple's strings file
public struct StringsFile {
    let entries: [Translation]

    /// Model of a strings file translation item
    public struct Translation {
        let translationKey: String
        let translation: String
        let comment: String?
    }
}

/// Parses a Apple's strings file to a `StringsFile` model
public final class StringsFileParser {
    private(set) var stringsFileData: String

    init(stringsFileData: String) {
        self.stringsFileData = stringsFileData
    }

    init?(stringsFilePath: String, fileReader: FileReader = PersistenceLayer()) {
        print("reading form \(stringsFilePath)")

        // Not the most effient way to read the whole file but
        // not a problem for the expected sizes this tool is expected to handle
        guard let contents = try? fileReader.readTextFromFile(path: stringsFilePath) else {
            print("could not read any data from \(stringsFilePath)")
            return nil
        }
        self.stringsFileData = contents
    }

    /// Parses a Apple's strings file to a `StringsFile` model
    func parse() -> StringsFile {
        var stringsFileEntries: [StringsFile.Translation] = []

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
        var translationsCounter = 0
        for line in stringsFileData.components(separatedBy: CharacterSet.newlines).map({ $0.trimmingCharacters(in: .whitespaces) }) {
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
                        stringsFileEntries.append(StringsFile.Translation(translationKey: String(key),
                                                                          translation: String(value),
                                                                          comment: previousComment))
                    } else {
                        print("translation not found for '\((key))' at line \(lineCounter) ")
                        stringsFileEntries.append(StringsFile.Translation(translationKey: String(key),
                                                                          translation: "",
                                                                          comment: previousComment))
                    }
                }
                previousComment = ""
                translationsCounter += 1
            } else if !line.isBlank {
                print("skipping '\(line)' at line \(lineCounter) ")
            }
        }

        return StringsFile(entries: stringsFileEntries)
    }
}
