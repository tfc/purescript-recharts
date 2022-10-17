module Main where

import Prelude
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import React.Basic (JSX)
import React.Basic.DOM as R
import React.Basic.DOM.Client (createRoot, renderRoot)
import Recharts as RC
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

data TextState
  = Failure
  | Success String

main :: Effect Unit
main = do
  doc <- document =<< window
  root <- getElementById "root" $ toNonElementParentNode doc
  case root of
    Nothing -> throw "Could not find root."
    Just container -> do
      reactRoot <- createRoot container
      renderRoot reactRoot app

app :: JSX
app = R.div_
  [ R.h1_ [ R.text "Pie Chart" ]
  , pieChart
  , R.h1_ [ R.text "Line Chart" ]
  , RC.responsiveContainer { width: "100%", height: 400, children: [ lineChart ] }
  ]

pieChart :: JSX
pieChart = RC.pieChart
  { width: 100
  , height: 100
  , children:
      [ RC.pie
          { data:
              [ { name: "a", value: 10 }
              , { name: "b", value: 20 }
              , { name: "c", value: 30 }
              ]
          , dataKey: "value"
          , nameKey: "name"
          , cx: "50%"
          , cy: "50%"
          , outerRadius: 50
          , fill: "#8884d8"
          }
      ]
  }

lineChart :: JSX
lineChart = RC.lineChart
  { data:
      [ { name: "a", val: 10 }
      , { name: "a", val: 12 }
      , { name: "a", val: 8 }
      , { name: "a", val: 10 }
      , { name: "a", val: 6 }
      , { name: "a", val: 14 }
      , { name: "a", val: 5 }
      , { name: "a", val: 12 }
      , { name: "a", val: 8 }
      , { name: "a", val: 20 }
      , { name: "a", val: 8 }
      , { name: "a", val: 12 }
      ]
  , children:
      [ RC.cartesianGrid {}
      , RC.xaxis {}
      , RC.yaxis { dataKey: "val" }
      , RC.line { dataKey: "val", type: "monotone" }
      , RC.legend {}
      , RC.tooltip {}
      ]
  }
