import Foundation // Import Foundation framework for basic Swift functionality
//import CredentialLib // Import Credential framework for account management
import UserDefaultSugar // Import UserDefaultSugar framework for user defaults management
import SDUtil
/**
 * Const - Options to use
 */
extension AppConfig {
   /**
    * We set a config here
    * - Description: Holds the current configuration for the app, which determines the state of user data and feature visibility.
    * - Fixme: ⚠️️ Remove this? or not? why?
    */
   public static var current: AppConfig = .retain() { // default
      didSet {
         apply(current)  // Call the apply function with the current app configuration when the app configuration is set
      }
   }
   /**
    * Reset all user data (`KeyChain`, `UserDefault`, `CoreData`)
    * - Description: Creates a configuration that will reset all user data upon application start. This is typically used for testing purposes to ensure the application starts in a known state without any user data from previous sessions.
    * - Parameters:
    *   - hidePayment: When in beta, payment in prefs and onboarding is hidden
    * - Returns: An `AppConfig` instance that clears user-data and loads dummy data for testing
    */
   public static func reset(db: DBKind/*hidePayment: Bool = true*/) -> AppConfig {
      .init(
//         hidePayment: hidePayment, // Set the hidePayment flag to the value of the hidePayment parameter
         db: db,
         resetKeyChain: true, // Set the resetKeyChain flag to true
         resetUserDefault: true, // Set the resetUserDefault flag to true
         resetDatabase: true // Set the resetCoreData flag to true
      )
   }
   /**
    * Keeps all current user data (used for release candidate)
    * - Description: Creates a configuration that retains all user data upon application start. This is typically used for production where data persistence is required across app launches.
    * - Remark: Use this for release (Persist data between launches)
    * - Fixme: ⚠️️ Move .retain.. to default static let value? or?
    * - Parameter hidePayment: When in beta, payment in prefs and onboarding is hidden
    */
   public static func retain(/*hidePayment: Bool = true*/) -> AppConfig {
      .init(/*hidePayment: hidePayment,*/ // Set whether payment should be hidden
            db: nil,
            resetKeyChain: false, // Set whether keychain should be reset
            resetUserDefault: false, // Set whether user defaults should be reset
            resetDatabase: false) // Set whether Core Data should be reset
   }
}
/**
 * Ext
 */
extension AppConfig: CustomStringConvertible {
   /**
    * (Used for debugging, to see config etc)
    * - Description: This property provides a string representation of the AppConfig instance, detailing the current configuration settings including whether payment is hidden, and whether the KeyChain, UserDefault, and CoreData are set to reset.
    */
   public var description: String {
      /*hidePayment: \(hidePayment) */ 
      "resetKeyChain: \(resetKeyChain) resetUserDefault: \(resetUserDefault) resetCoreData: \(resetDatabase)" // Create a string with AppConfig parameters
   }
}
