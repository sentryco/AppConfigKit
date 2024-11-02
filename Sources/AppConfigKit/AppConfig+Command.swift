import Foundation
import Key
//import CredentialLib
//import DatabaseLib
import UserDefaultSugar
//import Logger
//import PersistenceKit
import SDUtil
#if os(iOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif
/**
 * Apply
 */
extension AppConfig {
   /**
    * Configure user data (Universal for `iOS` and `macOS`)
    * - Description: Applies the configuration settings to the app by resetting CoreData, KeyChain, and UserDefault data based on the provided AppConfig flags.
    * - Remark: Called from `createWelcomeView` and `dismissLogin`
    * - Fixme: ⚠️️ We should verify that all data has been deleted maybe? how? why?
    * - Parameter config: `AppConfig` instance to apply to the app
    */
   internal static func apply(_ config: AppConfig) {
      // Logger.info("\(Trace.trace()) appConfig: \(config.description)", tag: .other) // Log the current trace and the app config description to the console
      if config.resetDatabase { // Check if the resetCoreData flag is set to true
         resetCoreData(db: config.db) // Wipe the database
      }
      if config.resetUserDefault { // Check if the resetUserDefault flag is set to true
         resetUserDefault() // Wipe the user defaults
      }
      if config.resetKeyChain { // Check if the resetKeyChain flag is set to true
         resetKeychain() // Wipe the keychain
      }
   }
}
/**
 * Reset
 */
extension AppConfig {
   /**
    * Reset `CoreData`, `KeyChain` and `UserDefault`
    * - Description: This function triggers the reset of CoreData, KeyChain, and UserDefault data to their default states, effectively clearing all persisted user data.
    */
   internal static func resetAll(db: DBKind?) {
      // Logger.info("\(Trace.trace()) 🧼", tag: .system) // Log the current trace and a soap emoji to the console
      resetCoreData(db: db) // Wipe the database
      resetKeychain() // Wipe the keychain
      resetUserDefault() // Wipe the user defaults
   }
   /**
    * 🗄 Reset Core-data
    * - Description: This function clears all data from the CoreData database, ensuring that no user data remains stored locally on the device.
    * - Note: Alternative names: `resetDatabase`, `resetSwiftData`
    * - Fixme: ⚠️️ Resetting "syncLog" might not be needed now that we destroy the core-data file etc, try to confirm this maybe? this works a bit different with swift-data
    * - Remark: DB is located in a similar path as: /Users/eon/Library/Group Containers/TW37UKNDCG.co.sentry.SentryApp
    * - Remark: DB path can be printed from `CDConfig.appGroupDir` path
    * - Remark: We have to destroy CoreData or else the internal CoreData item index doesn't get reset
    */
   fileprivate static func resetCoreData(db: DBKind?) { /* regen: Bool = true */
      // Logger.info("\(Trace.trace())", tag: .db) // Log the current trace to the console
      // do { // Clear core-data database
      guard let db: DBKind = db else { print("db not available"); return }
      SDUtil.resetDB(db: db/*CredentialDB.sharedInstance*/)
         // try CDUtil.destroy(config: DBModel.defaultConfig) // Reset SQLite file
         // try CDUtil.reset(config: DBModel.defaultConfig) // Alternative method to reset the database
         // try AFDB.shared.clearAll() // Alternative method to clear the database
      // } catch {
      //    Logger.error("\(Trace.trace()) - Reset core-data error: \(error.localizedDescription)", tag: .db) // Log an error to the console if the database reset fails
      // }
      // ⚠️️ We can't regen db here because then onboarding screen won't show
      // if regen {
      //    // - Fixme: ⚠️️ regen of context will happen naturally, I guess we don't do that anymore?
      //     _ = AFDB.shared.context // Regenerate context (if we call this later, then it might be on bg thread and it wont regen etc)
      //    // This should be wiped with file etc
      //     AFDB.shared.syncLog = [:] // Resets `sync-log` metadata
      // }
   }
   /**
    * 🔑 Clear all "key-chain's" for this app ("master-pass-key", "secure-user-default", "sec-db-key")
    * - Description: This function removes all entries from the keychain associated with the app, ensuring that sensitive data such as passwords and encryption keys are securely erased.
    */
   fileprivate static func resetKeychain() {
      // Logger.info("\(Trace.trace())", tag: .security) // Log the current trace to the console
      do { // Delete all keys from the keychain
         try Key.deleteAll() // Delete all keys from the keychain
      } catch {
         print("Reset keychain error: \(error.localizedDescription)")
         // Logger.error("\(Trace.trace()) - Reset keychain error: \(error.localizedDescription)", tag: .db) // Log an error to the console if the keychain reset fails
      }
   }
   /**
    * 📝 By clearing UserDefault we Trigger welcome-screen to show
    * - Description: This function removes all entries from the UserDefaults, which triggers the display of the welcome screen upon the next app launch. It is a critical step in ensuring that all non-secure configurations are reset to their default states.
    * - Remark: A way to also debug showing welcome screen
    * - Remark: By clearning UserDefault we also get to test the `onboarding-scheme`
    * - Remark: We have 3 tiers:
    * - Remark: 1. App sec config -> keychain store (use-master-password, use-bio-auth, etc)
    * - Remark: 2. `PeerManager` -> secure userdef
    * - Remark: 3. Non sec config -> normal userdef (isFirstLaunch, windowSize, other?)
    * - Remark: User default is located here: ~/Library/Preferences/co.sentry.SentryApp.plist
    * - Remark: User def is located here for sandboxed apps: ~/Library/Containers/co.sentry.SentryApp/Data/Library/Preferences/co.sentry.SentryApp.plist
    */
   fileprivate static func resetUserDefault() {
      // Logger.info("\(Trace.trace())", tag: .system) // Log the current trace to the console
      UserDefaults.removeAll() // Remove all user defaults
      // - Fixme: ⚠️️ try to figure out why onboarding is skipped 
//      Swift.print("Persistence.isNewInstall:  \(String(describing: Persistence.isNewInstall))")
//      Swift.print("👉 PrefsStore.$shouldPresentOnboarding: \(PrefsStore.$shouldPresentOnboarding.wrappedValue)")
   }
}
