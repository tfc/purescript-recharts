module Recharts where

-- moving this module to `Foreign.Recharts`/ the file to Foreign/Rechars.* leads
-- to a crashing ResponsiveContainer for some reason.

import Data.Maybe (Maybe)
import Data.Nullable (toMaybe)
import Prim.Row (class Union)
import React.Basic.Events (EventFn, EventHandler, SyntheticEvent, unsafeEventFn)
import React.Basic.Hooks (JSX, ReactComponent, element)
import Unsafe.Coerce (unsafeCoerce)

type Props_legend =
  ( width ∷ Int
  , height ∷ Int
  )

legend
  ∷ ∀ attrs attrs_
  . Union attrs attrs_ Props_legend
  ⇒ Record attrs
  → JSX
legend = element _legend

foreign import _legend ∷ ∀ attrs. ReactComponent attrs

tooltip
  ∷ ∀ attrs attrs_
  . Union attrs attrs_ ()
  ⇒ Record attrs
  → JSX
tooltip = element _tooltip

foreign import _tooltip ∷ ∀ attrs. ReactComponent attrs

type BrushIndex =
  { startIndex ∷ Int
  , endIndex ∷ Int
  }

targetBrushIndex ∷ EventFn SyntheticEvent (Maybe BrushIndex)
targetBrushIndex = unsafeEventFn \e → toMaybe (unsafeCoerce e)

type Props_brush =
  ( dataKey ∷ String
  , domain ∷ (Array String)
  , onChange ∷ EventHandler -- use handler targetBrushIndex
  , height ∷ Int
  , fill ∷ String
  , gap ∷ Int
  )

brush
  ∷ ∀ attrs attrs_
  . Union attrs attrs_ Props_brush
  ⇒ Record attrs
  → JSX
brush = element _brush

foreign import _brush ∷ ∀ attrs. ReactComponent attrs

type Props_axis a b =
  ( dataKey ∷ String
  , domain ∷ (Array String)
  , tickFormatter ∷ (a → b)
  )

xaxis
  ∷ ∀ attrs attrs_ a b
  . Union attrs attrs_ (Props_axis a b)
  ⇒ Record attrs
  → JSX
xaxis = element _xaxis

foreign import _xaxis ∷ ∀ attrs. ReactComponent attrs

yaxis
  ∷ ∀ attrs attrs_ a b
  . Union attrs attrs_ (Props_axis a b)
  ⇒ Record attrs
  → JSX
yaxis = element _yaxis

foreign import _yaxis ∷ ∀ attrs. ReactComponent attrs

cartesianGrid
  ∷ ∀ attrs attrs_
  . Union attrs attrs_ ()
  ⇒ Record attrs
  → JSX
cartesianGrid = element _cartesianGrid

foreign import _cartesianGrid ∷ ∀ attrs. ReactComponent attrs

type Props_line =
  ( type ∷ String
  , dataKey ∷ String
  , stroke ∷ String
  , dot ∷ Boolean
  , name ∷ String
  , fill ∷ String
  , fillOpacity ∷ String
  )

line
  ∷ ∀ attrs attrs_
  . Union attrs attrs_ Props_line
  ⇒ Record attrs
  → JSX
line = element _line

foreign import _line ∷ ∀ attrs. ReactComponent attrs

type Props_lineChart a =
  ( width ∷ Int
  , height ∷ Int
  , data ∷ Array a
  , children ∷ Array JSX
  , syncId ∷ String
  )

lineChart
  ∷ ∀ attrs attrs_ a
  . Union attrs attrs_ (Props_lineChart a)
  ⇒ Record attrs
  → JSX
lineChart = element _lineChart

foreign import _lineChart ∷ ∀ attrs. ReactComponent attrs

area
  ∷ ∀ attrs attrs_
  . Union attrs attrs_ Props_line
  ⇒ Record attrs
  → JSX
area = element _area

foreign import _area ∷ ∀ attrs. ReactComponent attrs

areaChart
  ∷ ∀ attrs attrs_ a
  . Union attrs attrs_ (Props_lineChart a)
  ⇒ Record attrs
  → JSX
areaChart = element _areaChart

foreign import _areaChart ∷ ∀ attrs. ReactComponent attrs

composedChart
  ∷ ∀ attrs attrs_ a
  . Union attrs attrs_ (Props_lineChart a)
  ⇒ Record attrs
  → JSX
composedChart = element _composedChart

foreign import _composedChart ∷ ∀ attrs. ReactComponent attrs

type Props_pieChart =
  ( width ∷ Int
  , height ∷ Int
  , children ∷ Array JSX
  )

pieChart
  ∷ ∀ attrs attrs_
  . Union attrs attrs_ Props_pieChart
  ⇒ Record attrs
  → JSX
pieChart = element _pieChart

foreign import _pieChart ∷ ∀ attrs. ReactComponent attrs

type Props_data =
  { name ∷ String
  , value ∷ Int
  }

type Props_pie =
  ( data ∷ Array Props_data
  , dataKey ∷ String
  , nameKey ∷ String
  , cx ∷ String
  , cy ∷ String
  , outerRadius ∷ Int
  , fill ∷ String
  )

pie
  ∷ ∀ attrs attrs_
  . Union attrs attrs_ Props_pie
  ⇒ Record attrs
  → JSX
pie = element _pie

foreign import _pie ∷ ∀ attrs. ReactComponent attrs

type Props_responsiveContainer =
  ( aspect ∷ Int
  , width ∷ String
  , height ∷ Int
  , children ∷ Array JSX
  )

responsiveContainer
  ∷ ∀ attrs attrs_
  . Union attrs attrs_ Props_responsiveContainer
  ⇒ Record attrs
  → JSX
responsiveContainer = element _responsiveContainer

foreign import _responsiveContainer ∷ ∀ attrs. ReactComponent attrs
