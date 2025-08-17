import Foundation

extension String {

    func toDate() -> Date? {
        let dateFormattes = ["yyyy-MM-dd'T'HH:mm:ss.SSSZ","yyyy-MM-dd'T'HH:mm:ss.SSS", "yyyy-MM-dd'T'HH:mm:ss", "yyyy-MM-dd'T'HH:mm:ss.SS", "yyyy-MM-dd'T'HH:mm:ss.SSSX", "yyyy-MM-dd'T'HH:mm:ssZ"]
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        for format in dateFormattes {
            dateFormatter.dateFormat = format
            
            if let date = dateFormatter.date(from: self) {
                return date
            }
        }

        return nil
    }
    
    var boolValue: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
    
    func isValidPhone() -> Bool {
           let phoneRegex = "^(0044|0|\\+?44)[12378]\\d{8,9}$"
           let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
           return phoneTest.evaluate(with: self)
       }

    func isValidEmail() -> Bool {
       // see 3. Restrictions on email addresses https://www.rfc-editor.org/rfc/rfc3696#section-3
       let emailRegEx = "[A-Z0-9a-z.!#$%&'*+/=?^_`{|}~-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       return emailPred.evaluate(with: self)
   }
    
    func isNumber() -> Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    func convertStringToDictionary() -> [String:AnyObject]? {
       if let data = self.data(using: .utf8) {
           do {
               let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
               return json
           } catch {
               print("Invalid Json String: \(self)")
           }
       }
       return nil
   }
    
    
    func daysRemainingFromCurrentDate() -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"

       if let gracePeriodDate = dateFormatter.date(from: self) {
           let numberOfDays = Calendar.current.dateComponents([.day], from: Date(), to: gracePeriodDate)
           if let days = numberOfDays.day {
               return days
           }
       }
       return nil
    }
}
