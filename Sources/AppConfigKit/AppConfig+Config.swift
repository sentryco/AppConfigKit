import Foundation // Import Foundation framework for basic Swift functionality
//import CredentialLib // Import Credential framework for account management
import UserDefaultSugar // Import UserDefaultSugar framework for user defaults management
//import Logger // Import Logger framework for logging functionality
import SDUtil
/**
 * Debug support
 */
extension AppConfig {
   /**
    * Debug (macOS / iOS)
    * - Abstract: This is used to retain or reset data from the UITest POV view via ProcessInfo and app delegate will finsih with options call in app root
    * - Description: This method configures the app's user data handling for debugging purposes. It determines whether to retain or reset user data based on the `resetUserData` parameter, which is influenced by the UITest environment or manual debugging needs.
    * - Remark: To retain with new userdefault. Wipe userdefault location, derived data and reset the macOS
    * - Fixme: ⚠️️ Use switch instead of nested if else etc, maybe yes
    * - Parameters:
    *   - resetUserData: Needs to be optional, so we can diff UITest or not
    *   - db: The database type to use for the application. Specifies which database implementation should be used.
    */
   public static func config(resetUserData: Bool?, db: DBKind) { // - Fixme: ⚠️️ set params in func
      #if DEBUG // Simulator / UITest (Exclude from prod code)
      // Logger.info("\(Trace.trace()) - debug resetUserData: \(String(describing: resetUserData))", tag: .system) // Log the current trace and the value of resetUserData to the console
      if let resetUserData: Bool = resetUserData { // Check if resetUserData is not nil
         if resetUserData == true { // Check if resetUserData is true
            // Swift.print("reset")
            AppConfig.current = .reset(db: db) // Configure app
         } // else do nothing
      } else { // Not UI-testing, is debug
         // Swift.print("retain")
         AppConfig.current = .retain() // For debugging release etc
      }
      #else // Release / TestFlight
      // Logger.info("\(Trace.trace()) - release", tag: .system) // Log the current trace to the console
      AppConfig.current = .retain() // Configure app
      #endif
   }
}
