# collapsible_navigation_bar

A customizable collapsible navigation bar.\n
The `collapsible_navigation_bar` package for Flutter allows you to easily use lots of element in one navigator bar
## Getting Started

![](https://raw.githubusercontent.com/melikhanHosdogdu/collapsible_navigation_bar/main/assets/example.gif)

First, add the `collapsible_navigation_bar` package to your [pubspec dependencies](https://pub.dev/packages/collapsible_navigation_bar/install).

To import `CollapsibleNavigationBar`:

```dart
import 'package:collapsible_navigation_bar/collapsible_navigation_bar.dart';
```

To use `CollapsibleNavigationBar` give as a widget your Scaffold widget:

```dart
    Scaffold(
        body: CollapsibleNavigationBar(),
      ),
```
and add reqired parameter

```dart
  CollapsibleNavigationBar(
    upperIcons: [],  // The icons of the elements in the first row 
    upperTitles: [], // The titles of the elements in the first row

    lowerIcons: [],  // The Icons of the underlying elements
    lowerTitles:[],  // The Titles of the underlying elements

    lineHeight:      // The height of bar [recommend lineHeight =  MediaQuery.of(context).size.height * 0.07 ]
    onChange:        // Give the function you want to happen when the index changes

    pages: []        // Give the pages you want to view 

    // Change the following properties as you wish

    dropDownIconWhenOpen;
    dropDownIconWhenClose;
    dropDownTitle;
     
    backgroundColor;
    activeElementColor;
    passiveactiveElementColor;
    shadowColor;
  ),
      
```