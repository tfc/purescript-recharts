{ name = "recharts"
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, dependencies =
  [ "console"
  , "effect"
  , "maybe"
  , "nullable"
  , "prelude"
  , "react-basic"
  , "react-basic-hooks"
  , "unsafe-coerce"
  ]
}
