# TaskFlow-GetX

A Flutter project created for learning and practicing **GetX State Management** step by step.

The goal of this project is to understand GetX concepts through small practical examples instead of only learning theory.

---

## 📚 Learning Progress

### ✅ Completed

- GetX installation
- GetX package setup
- Reactive state with `.obs`
- Reactive values with `.value`
- `Obx()`
- `GetxController`
- Controller methods
- `Get.put()`
- `Get.find()`
- GetX Bindings
- `Bindings.dependencies()`
- `GetMaterialApp`
- GetX Routes with `GetPage`
- `initialRoute`
- Connecting Routes → Bindings → Controllers → Screens
- Basic GetX project structure
- Practical Counter application

---

# 1. GetX

GetX is a Flutter package that provides several useful features:

```text
GetX
├── State Management
├── Navigation
└── Dependency Injection
```

In this project, we started with **State Management**.

---

# 2. Installing GetX

The package used in this project is:

```yaml
dependencies:
  get: ^4.7.3
```

Installation command:

```bash
flutter pub add get
```

Import:

```dart
import 'package:get/get.dart';
```

> `get` is the correct GetX package.

---

# 3. Reactive State — `.obs`

Normal Dart:

```dart
var counter = 0;
```

GetX reactive state:

```dart
var counter = 0.obs;
```

`.obs` makes the variable reactive.

Simple meaning:

> `.obs` tells GetX to observe the value and notify widgets when it changes.

---

# 4. `.value`

When using an Rx value, we access the actual value using `.value`.

Example:

```dart
var counter = 0.obs;

counter.value++;
```

Other examples:

```dart
counter.value = 10;

print(counter.value);
```

Remember:

```text
.obs
 ↓
Reactive value

.value
 ↓
Read/change the value
```

---

# 5. Obx()

`Obx()` listens to reactive variables and rebuilds the UI when their values change.

Example:

```dart
Obx(
  () => Text(
    '${counter.value}',
  ),
)
```

The basic GetX reactive pattern is:

```text
.obs
 ↓
.value
 ↓
Obx()
 ↓
UI rebuild
```

---

# 6. GetxController

Instead of keeping state and logic directly inside a Flutter widget, GetX allows us to create a controller.

Example:

```dart
class CounterController extends GetxController {
  var counter = 0.obs;

  void increment() {
    counter.value++;
  }

  void decrement() {
    counter.value--;
  }

  void resetCounter() {
    counter.value = 0;
  }
}
```

The controller contains:

```text
State
 +
Logic
```

This keeps the UI cleaner.

---

# 7. CounterController

Our practical project uses a `CounterController`.

Current controller:

```dart
import 'package:get/get.dart';

class CounterController extends GetxController {
  var counter = 0.obs;

  void increment() {
    counter.value++;
  }

  void decrement() {
    counter.value--;
  }

  void resetCounter() {
    counter.value = 0;
  }
}
```

The controller provides three actions:

```text
increment()
decrement()
resetCounter()
```

---

# 8. Get.put()

`Get.put()` is used to create and register a dependency with GetX.

Example:

```dart
Get.put(CounterController());
```

Simple meaning:

> Create the controller and register it with GetX.

Think:

```text
Get.put()
   ↓
Create + Register
```

---

# 9. Get.find()

`Get.find()` retrieves an already registered dependency.

Example:

```dart
final controller = Get.find<CounterController>();
```

Simple meaning:

> GetX, give me the CounterController that has already been registered.

Think:

```text
Get.put()
   ↓
Register
   ↓
Get.find()
   ↓
Retrieve
```

Important:

`Get.find()` cannot find a controller that has never been registered.

---

# 10. GetX Bindings

We learned that putting:

```dart
Get.put(CounterController());
```

directly inside the controller file is not the clean architecture we want.

Instead, we created a separate Binding.

File:

```text
lib/bindings/counter_binding.dart
```

Code:

```dart
import 'package:get/get.dart';
import 'package:taskflow_getx/controllers/counter_controller.dart';

class CounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CounterController());
  }
}
```

The Binding is responsible for:

```text
Dependency Registration
```

---

# 11. Screen

Our CounterScreen retrieves the controller using:

```dart
final controller = Get.find<CounterController>();
```

The screen does not create the controller.

The Binding does that.

The screen only uses the controller.

Example:

```dart
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CounterController>();

    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => Text(
              '${controller.counter.value}',
            ),
          ),
        ],
      ),
    );
  }
}
```

---

# 12. GetMaterialApp

To use GetX routing and other GetX features, we changed:

```dart
MaterialApp
```

to:

```dart
GetMaterialApp
```

Example:

```dart
return GetMaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'TaskFlow - GetX',
);
```

---

# 13. GetX Routes

We learned how to connect a route with a screen and its Binding.

Example:

```dart
GetPage(
  name: '/counter',
  page: () => const CounterScreen(),
  binding: CounterBinding(),
)
```

And:

```dart
initialRoute: '/counter',
```

The complete flow is:

```text
App starts
    ↓
initialRoute
    ↓
GetPage
    ↓
CounterBinding
    ↓
Get.put(CounterController())
    ↓
CounterScreen
    ↓
Get.find<CounterController>()
    ↓
Obx()
    ↓
UI
```

---

# 14. Current Project Architecture

Our current structure is:

```text
lib/
│
├── main.dart
│
├── bindings/
│   └── counter_binding.dart
│
├── controllers/
│   └── counter_controller.dart
│
└── screens/
    └── counter_screen.dart
```

### Responsibility of each folder

#### `controllers/`

Contains:

```text
State + Business Logic
```

Example:

```text
counter_controller.dart
```

#### `bindings/`

Contains:

```text
Dependency Registration
```

Example:

```text
counter_binding.dart
```

#### `screens/`

Contains:

```text
UI
```

Example:

```text
counter_screen.dart
```

#### `main.dart`

Contains:

```text
App Configuration
Routes
Theme
Initial Route
```

---

# 15. Complete GetX Architecture Learned So Far

Our current architecture can be visualized as:

```text
                    main.dart
                       │
                       ↓
                 GetMaterialApp
                       │
                       ↓
                 GetPage / Route
                       │
                       ↓
                CounterBinding
                       │
                       ↓
                 Get.put(...)
                       │
                       ↓
              CounterController
                       │
              ┌────────┴────────┐
              ↓                 ↓
          counter           Methods
              │                 │
              │        ┌────────┼────────┐
              │        ↓        ↓        ↓
              │   increment  decrement  reset
              │
              ↓
             Obx()
              │
              ↓
         CounterScreen
              │
              ↓
              UI
```

---

# 16. Counter App Features

The current practice application contains:

### Counter display

```text
0
```

### Decrement

```text
DEC -
```

Decreases the counter.

### Reset

```text
RESET
```

Sets the counter back to:

```text
0
```

### Increment

```text
INC +
```

Increases the counter.

---

# 17. Important Concepts to Remember

### `.obs`

```dart
var counter = 0.obs;
```

Makes state reactive.

### `.value`

```dart
counter.value++;
```

Reads or changes the reactive value.

### `Obx()`

```dart
Obx(
  () => Text('${counter.value}'),
)
```

Listens to reactive state and rebuilds the UI.

### `GetxController`

```dart
class CounterController extends GetxController
```

Holds state and logic.

### `Get.put()`

```dart
Get.put(CounterController());
```

Creates/registers a dependency.

### `Get.find()`

```dart
Get.find<CounterController>();
```

Retrieves an already registered dependency.

### `Bindings`

```dart
class CounterBinding extends Bindings
```

Organizes dependency registration.

### `GetPage`

```dart
GetPage(
  name: '/counter',
  page: () => const CounterScreen(),
  binding: CounterBinding(),
)
```

Connects a route, screen, and Binding.

---

# 🧠 GetX Mental Model

The most important pattern learned so far:

```text
.obs
 ↓
Reactive State
 ↓
GetxController
 ↓
Binding
 ↓
Get.put()
 ↓
Get.find()
 ↓
Obx()
 ↓
UI
```

Or even more simply:

```text
Controller → State + Logic
Binding    → Dependency
Screen     → UI
Route      → Connects everything
```

---

# 🚧 Next Topics

The next phase of GetX learning will cover:

```text
⬜ GetX Navigation
   ├── Get.to()
   ├── Get.back()
   ├── Get.off()
   ├── Get.offAll()
   ├── Passing arguments
   └── Receiving arguments

⬜ GetBuilder

⬜ GetX<T>

⬜ Get.lazyPut()

⬜ Dependency Injection

⬜ Controller Lifecycle

⬜ GetX Workers
   ├── ever()
   ├── once()
   ├── debounce()
   └── interval()

⬜ More advanced state management

⬜ Professional GetX folder architecture

⬜ Practical GetX project
```

---

# 🎯 Learning Approach

This project follows a practical learning approach:

```text
Theory
  ↓
Small Example
  ↓
Write Code Yourself
  ↓
Run the App
  ↓
Review / Fix
  ↓
Move to Next Concept
```

The goal is to understand **why GetX works**, not simply copy code.

---

## Flutter Resources

- [Flutter documentation](https://docs.flutter.dev/)
- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

---

## Project Status

**Current status:** 🟢 GetX fundamentals completed

**Next lesson:** 🚀 **GetX Navigation**
