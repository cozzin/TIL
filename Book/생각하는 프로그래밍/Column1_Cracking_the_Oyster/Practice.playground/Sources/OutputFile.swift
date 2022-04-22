import Foundation

public struct OutputFile {
    
    public static func write(text: String) {
        let docDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = "Output.txt"
        let outputFileUrl = docDirectory.appendingPathComponent(fileName)
        
        do {
            try text.write(to: outputFileUrl, atomically: true, encoding: .utf8)
            print("Scucess write file to \(outputFileUrl)")
        } catch {
            print("Failure error: \(error)")
        }
    }
    
}
