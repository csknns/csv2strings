import Foundation
import os.log
import libcsv2strings

let arguments = CommandLine.arguments

private func printUsage() {
    print("USAGE: \(arguments[0]) [<csv file> | <strings file>]")
}

if arguments.count != 2 {
    printUsage()
} else {
    let file = arguments[1]

    if file.hasSuffix("csv") {
        StringsConvertor().toStringsFile(file)
    } else if file.hasSuffix("strings") {
        StringsConvertor().toCSVFile(file)
    } else {
        printUsage()
    }
}
