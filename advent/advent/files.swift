import Foundation

func stringArray(fromFile: String) -> [String] {
	let url = URL(fileURLWithPath: "\(#file)").deletingLastPathComponent().appendingPathComponent(fromFile)
	let contents = try! String(contentsOf: url, encoding: String.Encoding.utf8)
	let input: [String] = contents.split(separator: "\n").map { String($0) }
	return input
}
