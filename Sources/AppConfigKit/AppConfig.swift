import Foundation
import SDUtil
/**
 * Config initial user-data for `macOS` and `iOS` app (developer / release)
 * - Description: Used to toggle between debugging and production mode with different things being reset etc
 * - Remark: We keep this in a standalone package, to ensure that we can use it in the apps and AF extensions (AF doesnt need all of this yet, but might in the future etc)
 * - Remark: We could also seperate AppConfig/Persistence and the other auth code, more similar to how it was done in legacy etc?
 * - Note: Alternative names: `AppOptions`, `AppSettings`? `AppCustomization`
 */
public struct AppConfig {
   /**
    * The database type to use for the application
    * - Description: This property determines which database implementation should be used by the application.
    * - Parameter db: An optional DBKind value that specifies the database type. If nil, no database will be used.
    */
   public let db: DBKind?
   /**
    * When in beta, payment in prefs and onboarding is hidden
    * - Description: This flag is used to hide or show payment options in the preferences and onboarding sections of the application. When set to true, these options are hidden.
    * - Remark: Disabled for now. Enable again when `AppStoreLib is more mature / tested etc
    * - Remark: So app-review don't get a hangup that IAP isn't fully working etc
    * - Fixme: ⚠️️ store this somewhere else
    */
   // public let hidePayment: Bool
   /**
    * - Description: This flag is used to determine whether to reset the KeyChain data or not. When set to true, the KeyChain data will be reset.
    * - Remark: KeyChain data persist after app deletion
    */
   public let resetKeyChain: Bool
   /**
    * - Description: This flag is used to determine whether to reset the UserDefault data or not. When set to true, the UserDefault data will be reset.
    * - Remark: `UserDefault` data does not persist after app deletion
    */
   public let resetUserDefault: Bool
   /**
    * - Description: This flag is used to determine whether to reset the CoreData database or not. When set to true, the CoreData database will be reset.
    * - Remark: `CoreData` is wiped if app is removed on iOS
    * - Fixme: ⚠️️ Find info on coredata is removed when app deleted for macOS
    */
   public let resetDatabase: Bool
}
