{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.Home where

import Foundation
import Yesod.Core
import CalcStructure
import Control.Applicative ((<$>), (<*>))
import Data.Text           (Text)
import Data.Time           (Day)
import Yesod
import Yesod.Form.Jquery

--import DBConnection

getHomeR :: Handler Html
getHomeR = do
    -- Generate the form to be displayed
    (widget, enctype) <- generateFormPost calculationForm
    defaultLayout
        [whamlet|
            <p>
                The widget generated contains only the contents
                of the form, not the form tag itself. So...
            <form method=post action=@{CalculationsR} enctype=#{enctype}>
                ^{widget}
                <p>It also doesn't include the submit button.
                <button>Submit
        |]

postCalculationsR :: Handler Html
postCalculationsR = do
            ((result, widget), enctype) <- runFormPost calculationForm
            case result of
                FormSuccess calculation -> defaultLayout [whamlet|<p>#{show calculation}|]
                _ -> defaultLayout
                    [whamlet|
                        <p>Invalid input, let's try again.
                        <form method=post action=@{CalculationsR} enctype=#{enctype}>
                            ^{widget}
                            <button>Submit
                    |]
calculationAForm :: AForm Handler Calculation
calculationAForm = Calculation
    <$> areq intField "First Operator" Nothing
    <*> areq (selectField operators) "Operand" Nothing
    <*> areq intField "Second Operator" Nothing
    <*> aopt intField "Result" Nothing
      where
        operators :: [(Char, Char)]
        operators = [('+', '+'), ('-','-'),('-','-'),('/','/')]

calculationForm :: Html -> MForm Handler (FormResult Calculation, Widget)
calculationForm = renderTable calculationAForm
