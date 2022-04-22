import Foundation

public struct InputFile {
    
    public static func readLines() -> [String] {
        guard let filePath = Bundle.main.path(forResource: "Input", ofType: "txt") else {
            print("Cannot file path")
            return []
        }
        
        do {
            let data = try String(contentsOfFile: filePath, encoding: .utf8)
            return data.components(separatedBy: .newlines)
        } catch {
            print("error: \(error)")
            return []
        }
    }
    
}
