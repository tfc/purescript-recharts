{ name = "recharts-example"
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
, dependencies =
  [ "console"
  , "effect"
  , "exceptions"
  , "maybe"
  , "prelude"
  , "react-basic"
  , "react-basic-dom"
  , "recharts"
  , "web-dom"
  , "web-html"
  ]
}
