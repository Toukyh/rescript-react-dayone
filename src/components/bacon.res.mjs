// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Core__Promise from "@rescript/core/src/Core__Promise.res.mjs";
import * as S$RescriptSchema from "rescript-schema/src/S.res.mjs";
import * as JsxRuntime from "react/jsx-runtime";

var baconStruct = S$RescriptSchema.array(S$RescriptSchema.string);

function constructBacon(x) {
  var val = S$RescriptSchema.parseWith(x, baconStruct);
  if (val.TAG === "Ok") {
    return {
            TAG: "Data",
            _0: val._0
          };
  } else {
    return {
            TAG: "Error",
            _0: S$RescriptSchema.$$Error.message(val._0)
          };
  }
}

function $$fetch$1() {
  return Core__Promise.$$catch(fetch("https://baconipsum.com/api/?type=meat-and-filler").then(function (res) {
                  if (res.ok) {
                    return res.json().then(function (res) {
                                return Promise.resolve(constructBacon(res));
                              });
                  } else {
                    return Promise.resolve({
                                TAG: "Error",
                                _0: res.status.toString() + ": " + res.statusText
                              });
                  }
                }), (function (param) {
                return Promise.resolve({
                            TAG: "Error",
                            _0: "Something went wrong"
                          });
              }));
}

function render(bacon) {
  if (typeof bacon !== "object") {
    return JsxRuntime.jsx("p", {
                children: "loading...",
                className: "my-3"
              });
  } else if (bacon.TAG === "Error") {
    return JsxRuntime.jsx("p", {
                children: bacon._0,
                className: "my-3"
              });
  } else {
    return bacon._0.map(function (text) {
                return JsxRuntime.jsx("p", {
                            children: text,
                            className: "my-3"
                          }, text);
              });
  }
}

export {
  $$fetch$1 as $$fetch,
  render ,
}
/* baconStruct Not a pure module */
