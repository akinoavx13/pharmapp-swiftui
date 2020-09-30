//
//  ImportService.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

import UIKit

enum ImportServiceError: Error {
    case fileNotFound
    case failedToReadFile
}

final class ImportService: ImportServiceContract {
    // MARK: - Properties

    static let shared: ImportServiceContract = ImportService()

    var drugs: [Drug] = []

    // MARK: - Lifecycle

    private init() {}

    // MARK: - Methods

    func loadItems() {
        loadDrugs()
    }

    private func loadDrugs() {
        guard
            let drugsContentFile = try? read(fileName: "CIS_bdpm")
        else { return }

        drugs = convert(fileContent: drugsContentFile)
            .compactMap {
                Drug(row: $0)
            }
    }

    private func read(fileName: String, type: String = "txt") throws -> String {
        guard
            let filePath = Bundle.main.path(forResource: fileName,
                                            ofType: type)
        else { throw ImportServiceError.fileNotFound }

        guard
            let contents = try? String(contentsOfFile: filePath,
                                       encoding: .ascii)
        else { throw ImportServiceError.failedToReadFile }

        return contents
    }

    private func convert(fileContent: String) -> [[String]] {
        var result: [[String]] = []
        let rows = fileContent.components(separatedBy: "\n")

        for row in rows {
            let columns = row
                .replacingOccurrences(of: "\r", with: "")
                .components(separatedBy: "\t")

            if columns.count > 1 {
                result.append(columns)
            }
        }

        return result
    }
}
