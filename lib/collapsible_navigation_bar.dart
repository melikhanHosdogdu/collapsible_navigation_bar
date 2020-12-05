library collapsible_navigation_bar;


import 'package:flutter/material.dart';

class CollapsibleNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;

  final List<IconData> upperIcons;
  final List<String> upperTitles;
  final List<IconData> lowerIcons;
  final List<String> lowerTitles;

  final IconData dropDownIconWhenOpen;
  final IconData dropDownIconWhenClose;

  final String dropDownTitle;

  /// [recommend lineHeight =  MediaQuery.of(context).size.height * 0.07 ]
  final double lineHeight;

  final Color backgroundColor;
  final Color activeElementColor;
  final Color passiveactiveElementColor;
  final Color shadowColor;

  final List<Widget> pages;
  CollapsibleNavigationBar({
    this.defaultSelectedIndex = 0,
    @required this.upperIcons,
    @required this.upperTitles,
    @required this.lowerIcons,
    @required this.lowerTitles,
    this.dropDownIconWhenOpen = Icons.arrow_downward,
    this.dropDownIconWhenClose = Icons.arrow_upward,
    this.dropDownTitle = "More",
    this.backgroundColor = Colors.white,
    this.activeElementColor = Colors.red,
    this.passiveactiveElementColor = Colors.grey,
    this.shadowColor = Colors.black12,

    /// [recommend lineHeight =  MediaQuery.of(context).size.height * 0.07 ]
    @required this.lineHeight,
    @required this.onChange,
    @required this.pages,
  })  : assert(upperIcons.length == upperTitles.length,
            "upperIcons.length and upperTitles.length must equals"),
        assert(lowerIcons.length == lowerTitles.length,
            "lowerIcons.length and lowerTitles.length must equals"),
        assert(upperIcons.length + lowerIcons.length == pages.length,
            "upperIcons.length + lowerIcons.length must equals to pages.lenght"),
        assert(upperIcons != null && lowerIcons != null && pages != null,
            "upperIcons, lowerIcon and pages can not be null"),
        assert(upperTitles != null && lowerTitles != null,
            "upperIcons, lowerIcon and pages can not be null"),
        assert(lineHeight != null && onChange != null,
            "lineHeight and onChange can not be null");

  @override
  _CollapsibleNavigationBarState createState() =>
      _CollapsibleNavigationBarState();
}

class _CollapsibleNavigationBarState extends State<CollapsibleNavigationBar> {
  int _selectedIndex = 0;
  int lineCount = 0;

  double _lineHeight = 0;
  double xOffset = 0;
  double yOffset = 0;

  bool isNavBarOpen = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
    _lineHeight = widget.lineHeight;

    if (widget.lowerIcons.length % 5 == 0) {
      lineCount = 1 + ((widget.lowerIcons.length / 5).floor());
    } else {
      lineCount = 2 + ((widget.lowerIcons.length / 5).floor());
    }
    yOffset = _lineHeight * (lineCount - 1);
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          child: Container(
            child: widget.pages[_selectedIndex],
            height: s.height,
            width: s.width,
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(1.0)
              ..rotateY(0),
            height: _lineHeight * lineCount,
            width: s.width,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  offset: Offset(-1, -1),
                  color: widget.shadowColor,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    for (int i = 0; i < widget.upperIcons.length; i++)
                      upperElement(i),
                    dropDownElement(),
                  ],
                ),
                Wrap(
                  children: [
                    for (int i = 0; i < widget.lowerIcons.length; i++)
                      lowerElement((widget.upperIcons.length + i))
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  lowerElement(
    int index,
  ) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      height: _lineHeight,
      width: MediaQuery.of(context).size.width / 5,
      decoration: index == _selectedIndex
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 4, color: widget.activeElementColor),
              ),
              gradient: LinearGradient(colors: [
                widget.activeElementColor.withOpacity(0.3),
                widget.activeElementColor.withOpacity(0.015),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            )
          : BoxDecoration(),
      child: InkWell(
        onTap: () {
          if (isNavBarOpen) {
            setState(() {
              yOffset = _lineHeight * (lineCount - 1);
              isNavBarOpen = false;
              _selectedIndex = index;
            });
          } else {
            setState(() {
              yOffset = 0;
              isNavBarOpen = true;
            });
          }
          widget.onChange(index - widget.upperIcons.length);
        },
        child: Column(
          children: [
            Icon(
              widget.lowerIcons[index - widget.upperIcons.length],
              color: index == _selectedIndex
                  ? widget.activeElementColor
                  : widget.passiveactiveElementColor,
            ),
            Text(
              widget.lowerTitles[index - widget.upperIcons.length],
              style: TextStyle(
                  color: index == _selectedIndex
                      ? widget.activeElementColor
                      : widget.passiveactiveElementColor),
            )
          ],
        ),
      ),
    );
  }

  upperElement(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      height: _lineHeight,
      width: MediaQuery.of(context).size.width / 5,
      decoration: index == _selectedIndex
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 4, color: widget.activeElementColor),
              ),
              gradient: LinearGradient(colors: [
                widget.activeElementColor.withOpacity(0.3),
                widget.activeElementColor.withOpacity(0.015),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            )
          : BoxDecoration(),
      child: InkWell(
        onTap: () {
          widget.onChange(index);
          setState(() {
            _selectedIndex = index;
            yOffset = _lineHeight * (lineCount - 1);
            isNavBarOpen = false;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.upperIcons[index],
              color: index == _selectedIndex
                  ? widget.activeElementColor
                  : widget.passiveactiveElementColor,
            ),
            Text(
              widget.upperTitles[index],
              style: TextStyle(
                  color: index == _selectedIndex
                      ? widget.activeElementColor
                      : widget.passiveactiveElementColor),
            )
          ],
        ),
      ),
    );
  }

  dropDownElement() {
    return Container(
      height: _lineHeight,
      width: MediaQuery.of(context).size.width / 5,
      decoration: _selectedIndex > 4
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 4, color: widget.activeElementColor),
              ),
              gradient: LinearGradient(colors: [
                widget.activeElementColor.withOpacity(0.3),
                widget.activeElementColor.withOpacity(0.015),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            )
          : BoxDecoration(),
      child: InkWell(
          onTap: () {
            if (isNavBarOpen) {
              setState(() {
                yOffset = _lineHeight * (lineCount - 1);
                isNavBarOpen = false;
              });
            } else {
              setState(() {
                yOffset = 0;
                isNavBarOpen = true;
              });
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isNavBarOpen
                    ? widget.dropDownIconWhenOpen
                    : widget.dropDownIconWhenClose,
                color: _selectedIndex > 4
                    ? widget.activeElementColor
                    : widget.passiveactiveElementColor,
              ),
              Text(
                widget.dropDownTitle,
                style: TextStyle(
                    color: _selectedIndex > 4
                        ? widget.activeElementColor
                        : widget.passiveactiveElementColor),
              )
            ],
          )),
    );
  }
}
