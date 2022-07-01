
import Foundation
import WebKit
import PopupDialog

class GlobalSingleton {
  static let sharedInstance = GlobalSingleton()
  
  let FIRE_BASE_APP_KEY = "AIzaSyC-fzoyrG3r4lUJnTas9p8ceSdU3vd0MjA"
  
  let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789")
  
  var app_Base_URL_Path =       "https://openapi.easy4ip.com"           // 테스트 API서버
  var app_Real_Base_URL_Path =   "https://homecam.seeguard.co.kr:8443/" // 실서버
    
  var accessToken_URL_Path =    "/openapi/accessToken"                  // 어드민 token
  
  var app_login_URL_Path =   "/api/login"                               // 로그인 API
  var app_Real_login_URL_Path =   "/class/class.member.php"             // 로그인 API
    
    
  var wkProcessPool = WKProcessPool()
  var cookiesDefaultsKey: String = "cookiesDefaultsKey"
  
  
    // MARK: - 이메일 유효성 검사
      func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
          let regex = try NSRegularExpression(pattern: emailRegEx)
          let nsString = emailAddressString as NSString
          let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
          
          if results.count == 0
          {
            returnValue = false
          }
          
        } catch let error as NSError {
          print("invalid regex: \(error.localizedDescription)")
          returnValue = false
        }
        
        return  returnValue
      }
      
      // MARK: - 비밀번호 유효성 검사
      func isValidPassword(passwordString: String) -> Bool {
        var returnValue = true
        let passwordRegEx = "(?=.*\\d)(?=.*[a-z])(?=.*[!@#$%^&*]).{8,20}"
        do {
          let regex = try NSRegularExpression(pattern: passwordRegEx)
          let nsString = passwordString as NSString
          let results = regex.matches(in: passwordString, range: NSRange(location: 0, length: nsString.length))
          
          if results.count == 0 {
            returnValue = false
          }
        } catch let error as NSError {
          print("invalid regex: \(error.localizedDescription)")
          returnValue = false
        }
        return returnValue
      }
      
      // MARK: - 특수문자 유효성 검사
      func isValidFunctionText(text: String) -> Bool {
        var returnValue = true
        let functionRegEx = "^(?=.*[A-Za-z0-9]).{3,12}"
        do {
          let regex = try NSRegularExpression(pattern: functionRegEx)
          let nsString = text as NSString
          let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
          
          if results.count == 0 {
            returnValue = false
          }
        } catch let error as NSError {
          print("invalid regex: \(error.localizedDescription)")
          returnValue = false
        }
        return returnValue
      }
  // MARK: - Null 체크
  func isNotNil(someObject: Any?) -> Bool {
    if someObject is String {
      if (someObject as? String) != nil {
        return true
      }else {
        return false
      }
    }else if someObject is Array<Any> {
      if (someObject as? Array<Any>) != nil {
        return true
      }else {
        return false
      }
    }else if someObject is Dictionary<AnyHashable, Any> {
      if (someObject as? Dictionary<String, Any>) != nil {
        return true
      }else {
        return false
      }
    }else if someObject is Data {
      if (someObject as? Data) != nil {
        return true
      }else {
        return false
      }
    }else if someObject is NSNumber {
      if (someObject as? NSNumber) != nil{
        return true
      }else {
        return false
      }
    }else if someObject is UIImage {
      if (someObject as? UIImage) != nil {
        return true
      }else {
        return false
      }
    }
    return false
  }
    
    func showAlertView(_ message:String) {
        // Prepare the popup assets
        let title = "알림"
        let message = message
        let image = UIImage()
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)
        popup.buttonAlignment = .horizontal
        popup.transitionStyle = .zoomIn
        
        // This button will not the dismiss the dialog
        let confirmButton = DefaultButton(title: "확인") {
            //print("Ah, maybe next time :)")
        }
        
        let cancelButton = CancelButton(title: "취소") {
            //
        }
        
        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
        popup.addButtons([confirmButton])
        
        // Present dialog
        let topViewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        topViewController?.present(popup, animated: true, completion: nil)
        //UIApplication.shared.keyWindow?.rootViewController?.navigationController?.present(popup, animated: true, completion: nil)
    }
}

extension String {
  
  func contains(_ find: String) -> Bool{
    return self.range(of: find) != nil
  }
  
  func containsIgnoringCase(_ find: String) -> Bool{
    return self.range(of: find, options: NSString.CompareOptions.caseInsensitive) != nil
  }
  
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
  
  func localizedWithComment(comment: String) -> String {
    return NSLocalizedString(self, comment:comment)
  }
}

extension UIWindow {
  static var key: UIWindow? {
    if #available(iOS 13, *) {
      return UIApplication.shared.windows.first { $0.isKeyWindow }
    } else {
      return UIApplication.shared.keyWindow
    }
  }
}
