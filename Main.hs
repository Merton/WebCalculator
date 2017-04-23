import Application () -- for YesodDispatch instance
import Foundation
import Yesod.Core


main :: IO ()
main = do
    man <- newManager
    warp 3000 $ App man
