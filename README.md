# custom_tabbarview

This package is almost identical to the TabBarView API in the Flutter SDK, but with enhanced customization capabilities.

<img src="https://github.com/user-attachments/assets/d23b9920-8fcd-4fcf-b7d7-d8c184af7937" width="200px" />

## Presets

<table style="border: 1px solid black">
    <tbody>
        <tr>
            <td align="center" style="border: 1px solid black">
                <img src="https://github.com/user-attachments/assets/44fa349b-9386-4cc5-ba77-b446a7b8f0a7" width="200px" />
            </td>
            <td align="center" style="border: 1px solid black">
                <img src="https://github.com/user-attachments/assets/17fcd557-e01a-496b-a42c-04c437c4660b" width="200px" />
            </td>
            <td align="center" style="border: 1px solid black">
                <img src="https://github.com/user-attachments/assets/59a1f0e4-e27b-4716-b103-f078571abf07" width="200px" />
            </td>   
        </tr>
        <tr>
            <td align="center" style="border: 1px solid black">
                <span>fade</span>
            </td>
            <td align="center" style="border: 1px solid black">
                <span>stack</span>
            </td>
            <td align="center" style="border: 1px solid black">
                <span>carousel</span>
            </td>   
        </tr>
        <tr>
            <td align="center" style="border: 1px solid black">
                <img src="https://github.com/user-attachments/assets/efe9a525-eb28-4c82-80d6-13bd9cbd520b" width="200px" />
            </td>
            <td align="center" style="border: 1px solid black">
                <img src="https://github.com/user-attachments/assets/89fc1456-e025-4a71-99a0-5e8201e21a65" width="200px" />
            </td>
            <td align="center" style="border: 1px solid black">
            </td>
        </tr>
        <tr>
            <td align="center" style="border: 1px solid black">
                <span>toss1</span>
            </td>
            <td align="center" style="border: 1px solid black">
                <span>toss2</span>
            </td>
            <td align="center" style="border: 1px solid black">
            </td>
        </tr>
    </tbody>
</table>

## Features

1. It's a direct clone of TabBarView from the Flutter SDK, so more than 95% of the codebase is identical and reliable.
2. The widgets in children(tabs) are all built lazily, with keepAlive behavior as needed.
   ![lazy_build](https://github.com/user-attachments/assets/48eb4e79-c23e-4dd4-acbe-937d3c6d6010)
3. Transition animations are 100% customizable based on transition rate.
4. There are plenty of presets to get you started quickly, and hints for customization.

## Migration guide

### from TabBarView to CustomTabBarView

If you were previously using TabBarView, you can follow these steps to migrate.

1. Change from `TabBarView` to `CustomTabBarView`.

If you want to use the main feature -- `.builder` in addition, you can follow the steps below.

2. Rename `chindren` to `tabs`.
3. Implement `builder` type of `CustomTabBarViewBuilder` or just use other named constructor.

### from v0.x to v1.x

If you were previously using CustomTabBarView.builder, you can follow these steps to migrate.

1. Change from `builder` constructor to `custom`.
2. Change from `builder` parameter to `builderDelegate` and put previous builder function into builderDelegate class.

```dart
// AS-IS
CustomTabBarView.builder(
  controller: controller,
  tabs: tabs,
  builder: (context, pageController, childrenWithKey, index) {
    return childrenWithKey[index];
  }
)
// TO-BE
CustomTabBarView.custom(
  controller: controller,
  tabs: tabs,
  builderDelegate: CustomTabBarViewCustomBuilderDelegate(
    (context, pageController, childrenWithKey, index) {
      return childrenWithKey[index];
    },
  ),
)
```

## Types (new API)

### CustomTabBarViewBuilder

The type of builder method used globally in CustomTabBarView.

It returns a Widget and takes the following arguments:

- `context`: `BuildContext` for the widget.
- `offset`: The offset value for each widget in the TabBarView.
  1: left / 0: center / -1: right
- `widget`: Each child widget of tabs.

### CustomTabBarViewCustomBuilder

The type of custom builder method used globally in CustomTabBarView.

It returns a Widget and takes the following arguments:

- `context`: `BuildContext` for the widget.
- `pageController`: A `PageController` for PageView that internally implements TabBarView.
- `childrenWithKey`: The children or tabs passed in.  
  However, the implementation of TabBarView temporarily changes the order of the child widgets on transition.
- `index`: The index of the widget currently being displayed in the TabBarView.

> [!IMPORTANT]
> You can get the child that match the TabController with `childrenWithKey[index]`.

## Example

Except for the default constructor, the code snippet below performs the same behavior.

### default constructor

```dart
CustomTabBarView(
  controller: _tabController,
  children: _children,
)
```

### builder

```dart
CustomTabBarView.builder(
  controller: _tabController,
  tabs: _children,
  builder: (context, offset, child) {
    final dx = offset * width * 0.8;
    final scale = 1 - offset.abs() * 0.1;
    final opacity = 1 - offset.abs() * 2;

    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Transform.scale(
        scale: scale,
        child: Transform.translate(offset: Offset(dx, 0), child: child),
      ),
    );
  },
)
```

### custom 1

```dart
CustomTabBarView.custom(
  controller: _tabController,
  physics: const PageScrollPhysics(),
  dragStartBehavior: DragStartBehavior.down,
  tabs: _children,
  builderDelegate: CustomTabBarViewBuilderDelegate(
    (context, offset, child) {
      final dx = offset * width * 0.8;
      final scale = 1 - offset.abs() * 0.1;
      final opacity = 1 - offset.abs() * 2;

      return Opacity(
        opacity: opacity.clamp(0.0, 1.0),
        child: Transform.scale(
          scale: scale,
          child: Transform.translate(offset: Offset(dx, 0), child: child),
        ),
      );
    },
  ),
)
```

### custom 2

```dart
CustomTabBarView.custom(
  controller: _tabController,
  tabs: _children,
  builderDelegate: CustomTabBarViewCustomBuilderDelegate(
    (context, pageController, childrenWithKey, index) {
      return AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          final page = pageController.page ??
              pageController.initialPage.toDouble();
          final offset = (page - index) * pageController.viewportFraction;

          final dx = offset * width * 0.8;
          final scale = 1 - offset.abs() * 0.1;
          final opacity = 1 - offset.abs() * 2;

          return Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: scale,
              child: Transform.translate(
                  offset: Offset(dx, 0), child: child),
            ),
          );
        },
        child: childrenWithKey[index],
      );
    },
  ),
)
```

### preset

```dart
 CustomTabBarView.carousel(
  controller: _tabController,
  physics: const PageScrollPhysics(),
  dragStartBehavior: DragStartBehavior.down,
  tabs: _children,
)
```
