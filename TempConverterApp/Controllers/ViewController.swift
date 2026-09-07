import Foundation
internal import Combine

class ViewController: ObservableObject {
    
    var tempConverter: TempConverter = TempConverter()
    
    @Published var inputTempString: String = ""
    @Published var convertedTempString: String = "N/A"
    @Published var isConvertingCtoF: Bool = true
    
    func setInputTempString(_ input: String) {
        inputTempString = input
    }
    
    func setConvertedTempString() {
        let convertedTemp = tempConverter.getConvertedTemp()
        
        if let convertedTemp = convertedTemp {
            convertedTempString = String(convertedTemp)
        } else {
            convertedTempString = "N/A"
        }
    }
    
    func setInputTempUnit() {
        if isConvertingCtoF {
            tempConverter.setInputUnit(.celsius)
        } else {
            tempConverter.setInputUnit(.fahrenheit)
        }
    }
    
    func convert() {
        let inputTemp = Int(inputTempString) ?? -500
        
        setInputTempUnit()
        tempConverter.setInputTemp(inputTemp)
        tempConverter.convert()
        setConvertedTempString()
    }
}
