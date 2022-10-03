module Recharts where

import Data.Nullable (Nullable)
import Prim.Row (class Union)
import React.Basic.Hooks (JSX, ReactComponent, element)

{- All these bindings are basically deduced from the Recharts API Documentation:
  https://recharts.org/en-US/api

  It contains the bare minimum that is needed to get the Main.purs to run with
  the example charts.
-}

type Props_legend =
  ( width :: Nullable Int
  , height :: Nullable Int
  )

legend
  :: forall attrs attrs_
   . Union attrs attrs_ Props_legend
  => Record attrs
  -> JSX
legend = element _legend

foreign import _legend :: forall attrs. ReactComponent attrs

tooltip
  :: forall attrs attrs_
   . Union attrs attrs_ ()
  => Record attrs
  -> JSX
tooltip = element _tooltip

foreign import _tooltip :: forall attrs. ReactComponent attrs

type Props_axis =
  ( dataKey :: Nullable String
  )

xaxis
  :: forall attrs attrs_
   . Union attrs attrs_ Props_axis
  => Record attrs
  -> JSX
xaxis = element _xaxis

foreign import _xaxis :: forall attrs. ReactComponent attrs

yaxis
  :: forall attrs attrs_
   . Union attrs attrs_ Props_axis
  => Record attrs
  -> JSX
yaxis = element _yaxis

foreign import _yaxis :: forall attrs. ReactComponent attrs

cartesianGrid
  :: forall attrs attrs_
   . Union attrs attrs_ ()
  => Record attrs
  -> JSX
cartesianGrid = element _cartesianGrid

foreign import _cartesianGrid :: forall attrs. ReactComponent attrs

type Props_lineData =
  { name :: String
  , val :: Int
  }

type Props_line =
  ( type :: Nullable String
  , dataKey :: String
  , stroke :: Nullable String
  )

line
  :: forall attrs attrs_
   . Union attrs attrs_ Props_line
  => Record attrs
  -> JSX
line = element _line

foreign import _line :: forall attrs. ReactComponent attrs

type Props_lineChart =
  ( width :: Int
  , height :: Int
  , data :: Array Props_lineData
  , children :: Array JSX
  )

lineChart
  :: forall attrs attrs_
   . Union attrs attrs_ Props_lineChart
  => Record attrs
  -> JSX
lineChart = element _lineChart

foreign import _lineChart :: forall attrs. ReactComponent attrs

type Props_pieChart =
  ( width :: Int
  , height :: Int
  , children :: Array JSX
  )

pieChart
  :: forall attrs attrs_
   . Union attrs attrs_ Props_pieChart
  => Record attrs
  -> JSX
pieChart = element _pieChart

foreign import _pieChart :: forall attrs. ReactComponent attrs

type Props_data =
  { name :: String
  , value :: Int
  }

type Props_pie =
  ( data :: Array Props_data
  , dataKey :: String
  , nameKey :: String
  , cx :: String
  , cy :: String
  , outerRadius :: Int
  , fill :: String
  )

pie
  :: forall attrs attrs_
   . Union attrs attrs_ Props_pie
  => Record attrs
  -> JSX
pie = element _pie

foreign import _pie :: forall attrs. ReactComponent attrs

