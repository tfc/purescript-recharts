import esbuild from "esbuild";
import * as fs from "node:fs";
import path from "path";
import {fileURLToPath} from "url";
import PureScriptPlugin from "esbuild-plugin-purescript";

fs.rmSync("dist", {"recursive": true, "force": true});
fs.mkdirSync("dist");

fs.cpSync("index.html", "dist/index.html");

function build (opts) {
  esbuild.build(opts).then((result) => {
    if (result.errors.length > 0) { console.error(result.errors); }
    if (result.warnings.length > 0) { console.error(result.warnings); }
  });
}

const outdir = path.join(path.dirname(fileURLToPath(import.meta.url)), "dist");

build({
  bundle: true,
  minify: true,
  entryPoints: ["src/main.mjs"],
  outdir: outdir,
  plugins: [ PureScriptPlugin({ sources: [ "src/**/*.purs", ], }) ],
});
