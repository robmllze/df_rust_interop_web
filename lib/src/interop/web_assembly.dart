//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by dev-cetera.com & contributors. The use of this
// source code is governed by an MIT-style license described in the LICENSE
// file located in this project's root directory.
//
// See: https://opensource.org/license/mit
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// See: https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface.
@JS('WebAssembly')
@staticInterop
extension type WebAssembly(JSObject jsObject) implements JSObject {
  /// See: https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface/instantiate_static
  external static JSPromise<WebAssembly> instantiate(
    JSObject bufferSource,
    JSObject importObject,
  );

  /// See: https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface/instantiate_static
  external static JSPromise<WebAssembly> instantiateStreaming(
    JSObject source,
    JSObject importObject,
  );

  external WebAssemblyModule get module;
  external WebAssemblyInstance get instance;
}

/// See: https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface/Module
@JS('WebAssembly.Instance')
extension type WebAssemblyInstance(JSObject jsObject) implements JSObject {
  external JSObject get exports;
  WebAssemblyMemory get memory => exports['memory'] as WebAssemblyMemory;
}

/// See: https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface/Module
@JS('WebAssembly.Module')
extension type WebAssemblyModule(JSObject jsObject) implements JSObject {}

/// See: https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface/Global
@JS('WebAssembly.Global')
extension type WebAssemblyGlobal(JSObject jsObject) implements JSObject {}

/// See: https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface/Memory
@JS('WebAssembly.Memory')
extension type WebAssemblyMemory(JSObject jsObject) implements JSObject {
  external JSArrayBuffer get buffer;
}

/// See: https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface/Table
@JS('WebAssembly.Table')
extension type WebAssemblyTable(JSObject jsObject) implements JSObject {
  external JSObject get prototype;
}

/// See: https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface/Tag
@JS('WebAssembly.Tag')
extension type WebAssemblyTag(JSObject jsObject) implements JSObject {}

/// See: https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface/Exception
@JS('WebAssembly.Exception')
extension type WebAssemblyException(JSObject jsObject) implements JSObject {}

/// See: https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface/CompileError
@JS('WebAssembly.CompileError')
extension type WebAssemblyCompileError(JSObject jsObject) implements JSObject {}

/// See: https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface/LinkError
@JS('WebAssembly.LinkError')
extension type WebAssemblyLinkError(JSObject jsObject) implements JSObject {}

/// See: https://developer.mozilla.org/en-US/docs/WebAssembly/JavaScript_interface/RuntimeError
@JS('WebAssembly.RuntimeError')
extension type WebAssemblyRuntimeError(JSObject jsObject) implements JSObject {}
