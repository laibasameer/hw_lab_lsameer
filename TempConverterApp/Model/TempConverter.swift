import Foundation

class TempConverter {
    
    enum TemperatureUnit {
        case fahrenheit
        case celsius
    }
    
    var isConvertingCtoF = true
    var inputTemp: Int = 0
    var convertedTemp: Int? = nil
    
    func isBelowAbsoluteZero() -> Bool {
        if isConvertingCtoF {
            return inputTemp < -273
        } else {
            return inputTemp < -459
        }
    }
    
    func setInputUnit(_ tempUnit: TemperatureUnit) {
        switch tempUnit {
        case .celsius:
            isConvertingCtoF = true
        case .fahrenheit:
            isConvertingCtoF = false
        }
    }
    
    func setInputTemp(_ temp: Int) {
        inputTemp = temp
    }
    
    func getConvertedTemp() -> Int? {
        return convertedTemp
    }
    
    private func celsiusToFahrenheit() {
        convertedTemp = Int(Double(inputTemp) * 9 / 5 + 32)
    }
    
    private func fahrenheitToCelsius() {
        convertedTemp = Int((Double(inputTemp) - 32) * 5 / 9)
    }
    
    func convert() {
        guard !isBelowAbsoluteZero() else {
            convertedTemp = nil
            return
        }
        
        if isConvertingCtoF {
            celsiusToFahrenheit()
        } else {
            fahrenheitToCelsius()
        }
    }
}
