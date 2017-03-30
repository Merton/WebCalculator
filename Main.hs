import Application () -- for YesodDispatch instance
import Foundation
import Yesod.Core
--import DBConnection

main :: IO ()
main = warp 3000 App
