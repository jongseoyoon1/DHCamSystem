
import UIKit
import Alamofire
import PopupDialog
import SwiftyJSON

class CookieHandler {
  
  static let shared: CookieHandler = CookieHandler()
  
  let defaults = UserDefaults.standard
  let cookieStorage = HTTPCookieStorage.shared
  
  func getCookie(forURL url: String) -> [HTTPCookie] {
    let computedUrl = URL(string: url)
    let cookies = cookieStorage.cookies(for: computedUrl!) ?? []
    
    return cookies
  }
  
  func backupCookies(forURL url: String) -> Void {
    var cookieDict = [String : AnyObject]()
    
    for cookie in self.getCookie(forURL: url) {
      cookieDict[cookie.name] = cookie.properties as AnyObject?
    }
    
    defaults.set(cookieDict, forKey: "Constants.cookiesDefaultsKey")
  }
  
  func restoreCookies() {
    if let cookieDictionary = defaults.dictionary(forKey: "Constants.cookiesDefaultsKey") {
      
      for (_, cookieProperties) in cookieDictionary {
        if let cookie = HTTPCookie(properties: cookieProperties as! [HTTPCookiePropertyKey : Any] ) {
          cookieStorage.setCookie(cookie)
        }
      }
    }
  }
}

class DHNetworkingProtocol: NSObject {
  let URLPath = GlobalSingleton.sharedInstance
  
    // MARK: - 로그인
      func autoLoginProcess (_ params: Parameters, completionHandler:@escaping (_ indexes: DHLoginData.LoginData)->()) {
        
        let urlPathString = String(format:"%@%@/", URLPath.app_Real_Base_URL_Path, URLPath.app_Real_login_URL_Path)
        let header: HTTPHeaders = [ "Content-Type": "application/x-www-form-urlencoded" ]
          
        AF.request(urlPathString, method: .post, parameters: params, headers: header).responseData { response in
          //print(response.result)
          //print(response)
          
          switch response.result {
          case .success(let data):
            CookieHandler.shared.backupCookies(forURL: urlPathString)
            
            let jsonaa = JSON(data)
            //print(jsonaa)
            do {
              let getInstanceData = try JSONDecoder().decode(DHLoginData.LoginData.self, from: jsonaa.rawData(options: .prettyPrinted))
              completionHandler(getInstanceData)
            } catch {
              print(error)
              let jsonData = "{\"res\":\"NO\"}".data(using: .utf8)
              do {
                let getInstanceData = try JSONDecoder().decode(DHLoginData.LoginData.self, from: jsonData!)
                completionHandler(getInstanceData)
              } catch {
                print(error)
              }
            }
            break
          case .failure(let error):
            print(error)
            
            //self.showAlertView("데이터 호출 실패: 관리자에게 문의하세요!")
            break
          }
        }
      }
    
    // MARK: - 이메일 중복체크
      func emailProcess (_ params: Parameters, completionHandler:@escaping (_ indexes: DHLoginData.LoginData)->()) {
        
        let urlPathString = String(format:"%@%@/", URLPath.app_Real_Base_URL_Path, URLPath.app_Real_login_URL_Path)
        let header: HTTPHeaders = [ "Content-Type": "application/x-www-form-urlencoded" ]
          
        AF.request(urlPathString, method: .post, parameters: params, headers: header).responseData { response in
          print(response.result)
          print(response)
          
          switch response.result {
          case .success(let data):
            CookieHandler.shared.backupCookies(forURL: urlPathString)
            
            let jsonaa = JSON(data)
            //print(jsonaa)
            do {
              let getInstanceData = try JSONDecoder().decode(DHLoginData.LoginData.self, from: jsonaa.rawData(options: .prettyPrinted))
              completionHandler(getInstanceData)
            } catch {
              print(error)
              let jsonData = "{\"res\":\"NO\"}".data(using: .utf8)
              do {
                let getInstanceData = try JSONDecoder().decode(DHLoginData.LoginData.self, from: jsonData!)
                completionHandler(getInstanceData)
              } catch {
                print(error)
              }
            }
            break
          case .failure(let error):
            print(error)
            
            //self.showAlertView("데이터 호출 실패: 관리자에게 문의하세요!")
            break
          }
        }
      }
    
    
    
    // MARK: - 회원가입
      func joinProcess (_ params: Parameters, completionHandler:@escaping (_ indexes: DHLoginData.LoginData)->()) {
        
        let urlPathString = String(format:"%@%@/", URLPath.app_Real_Base_URL_Path, URLPath.app_Real_login_URL_Path)
        let header: HTTPHeaders = [ "Content-Type": "application/x-www-form-urlencoded" ]
          
        AF.request(urlPathString, method: .post, parameters: params, headers: header).responseData { response in
          //print(response.result)
          //print(response)
          
          switch response.result {
          case .success(let data):
            CookieHandler.shared.backupCookies(forURL: urlPathString)
            
            let jsonaa = JSON(data)
            //print(jsonaa)
            do {
              let getInstanceData = try JSONDecoder().decode(DHLoginData.LoginData.self, from: jsonaa.rawData(options: .prettyPrinted))
              completionHandler(getInstanceData)
            } catch {
              print(error)
              let jsonData = "{\"res\":\"NO\"}".data(using: .utf8)
              do {
                let getInstanceData = try JSONDecoder().decode(DHLoginData.LoginData.self, from: jsonData!)
                completionHandler(getInstanceData)
              } catch {
                print(error)
              }
            }
            break
          case .failure(let error):
            print(error)
            
            //self.showAlertView("데이터 호출 실패: 관리자에게 문의하세요!")
            break
          }
        }
      }
    }

extension DHNetworkingProtocol {
    
    func getPostString(params: [String : Any]) -> String {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
            
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    func saveCookies(response: AFDataResponse<Any>) {
        let headerFields = response.response?.allHeaderFields as! [String: String]
        let url = response.response?.url
        
        //print("로그인 쿠키1 ====== \(headerFields)")
        //print("로그인 쿠키2 ====== \(url!)")
        
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url!)
        var cookieArray = [[HTTPCookiePropertyKey: Any]]()
        for cookie in cookies {
            cookieArray.append(cookie.properties!)
        }
        
        print("로그인 쿠키 ====== \(cookieArray)")
        
        UserDefaults.standard.set(cookieArray, forKey: "savedCookies")
        UserDefaults.standard.synchronize()
    }
}

private protocol _Optional {
    func unwrappedString() -> String
}

extension Optional: _Optional {
    fileprivate func unwrappedString() -> String {
        switch self {
        case .some(let wrapped as _Optional): return wrapped.unwrappedString()
        case .some(let wrapped): return String(describing: wrapped)
        case .none: return String(describing: self)
        }
    }
}

postfix operator ~?
public postfix func ~? <X> (x: X?) -> String {
    return x.unwrappedString()
}
