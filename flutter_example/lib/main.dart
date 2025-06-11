// ignore_for_file: avoid_print

import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:df_rust_interop_web/df_rust_interop_web.dart';

int _ptr = 0;
int _len = 0;

List<num> numbers = [];

int _allocate(WebAssembly webAssembly, int size) {
  // Get the memory buffer from the WebAssembly instance
  final memory = webAssembly.instance.memory;
  final memoryBuffer = memory.buffer;

  // Create a Uint8List view of the memory buffer
  final bytes = memoryBuffer.toDart.asUint8List();

  // Find the first available space in the memory
  for (int i = 0; i < bytes.length - size; i++) {
    bool spaceAvailable = true;

    // Check if there's enough space
    for (int j = 0; j < size; j++) {
      if (bytes[i + j] != 0) {
        spaceAvailable = false;
        break;
      }
    }

    if (spaceAvailable) {
      // Mark this space as used
      for (int j = 0; j < size; j++) {
        bytes[i + j] = 1; // Using 1 to mark as used
      }
      return i; // Return the starting index as the pointer
    }
  }

  throw Exception('Not enough memory available');
}

int allocateStringMemory(WebAssembly webAssembly, String input) {
  final length = input.length;
  final memorySize = length + 1; // +1 for null terminator
  final memoryPointer = _allocate(webAssembly, memorySize); // Allocate memory

  // Convert the string to bytes
  final inputBytes = Uint8List.fromList(input.codeUnits);

  // Copy the bytes into WebAssembly memory
  final byteBuffer = _byteBuffer(webAssembly);
  final memory = byteBuffer.asUint8List();

  // Check if the memoryPointer + length exceeds the bytes length
  if (memoryPointer + memorySize > memory.length) {
    throw Exception('Memory pointer out of bounds');
  }

  // Copy input bytes to the allocated memory
  for (int i = 0; i < length; i++) {
    memory[memoryPointer + i] = inputBytes[i]; // Set each byte
  }
  memory[memoryPointer + length] = 0; // Null-terminate the string

  return memoryPointer; // Return the pointer to the string in memory
}

ByteBuffer _byteBuffer(WebAssembly webAssembly) {
  final memory = webAssembly.instance.memory;
  final memoryBuffer = memory.buffer;
  final byteBuffer = memoryBuffer.toDart;
  return byteBuffer;
}

// ignore: unused_element
Uint8List _uint8List(WebAssembly webAssembly) {
  final byteBuffer = _byteBuffer(webAssembly);
  final bytes = byteBuffer.asUint8List(_ptr, _len);
  return bytes;
}

String getString(WebAssembly webAssembly, int ptr, int len) {
  final byteBuffer = _byteBuffer(webAssembly);
  final bytes = byteBuffer.asUint8List(ptr, len);
  return String.fromCharCodes(bytes);
}

void main() async {
  final result = await loadJSArrayBufferFromURL('assets/rust_functions/pkg/rust_functions_bg.wasm');
  final jsArrayBuffer = result.buffer!;

  final imports = JSObject();

  final wbg = JSObject();
  imports['wbg'] = wbg;

  wbg['__wbindgen_string_get'] = (e) {
    print('String Get: $e');
  }.jsify();

  wbg['__wbindgen_string_new'] = (int ptr, int len) {
    print('String New: $ptr, $len');
    _ptr = ptr;
    _len = len;
  }.jsify();

  wbg['__wbindgen_is_string'] = (e) {
    print('Is String: $e');
    return e is String || e is JSString;
  }.jsify();

  wbg['__wbindgen_object_drop_ref'] = (e) {
    print('Dropping reference for: $e');
  }.jsify();

  wbg['__wbg_new_034f913e7636e987'] = (e) {}.jsify();

  wbg['__wbg_push_36cf4d81d7da33d1'] = (e) {}.jsify();

  wbg['__wbindgen_throw'] = (e) {
    print('Throwing error: $e');
  }.jsify();

  wbg['__wbindgen_number_new'] = (num a) {
    numbers.add(a);
  }.jsify();

  final webAssembly = await WebAssembly.instantiate(jsArrayBuffer, imports).toDart;

  // Retrieve the exports
  final exports = webAssembly.instance.exports.dartify() as Map;

  numbers.clear();
  final ref = allocateStringMemory(webAssembly, 'hello there!!!');
  print(getString(webAssembly, ref, 'hello there!!!'.length));
  final stringLength = exports['string_length'](ref);
  print(stringLength);
  print(numbers);

  // print(exports);

  // final helloWorld = exports['hello_world']();

  // Call the hello_world function
  numbers.clear();
  // ignore: unused_local_variable
  final returnTwoInts = exports['return_two_ints']();
  // print(numbers);

  // exports['hello_world']();
  // print(String.fromCharCodes(_uint8List(webAssembly)));

  // print(helloWorld);
  // final byeWorld = exports['bye_world']();
  // print(byeWorld);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
