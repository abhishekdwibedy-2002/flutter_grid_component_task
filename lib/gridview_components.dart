import 'package:flutter/material.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({
    super.key,
    required this.title,
    required this.lists,
    required this.last,
    required this.onClicked,
    required this.onItemSelect,
    required this.optionIndex,
    required this.showIcon,
  });

  final String title;
  final List lists;
  final int last;
  final Function(bool) onClicked;
  final Function(int) onItemSelect;
  final int? optionIndex;
  final bool showIcon;

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: widget.lists.length <= widget.last
                  ? widget.lists.length
                  : widget.last + 1,
              itemBuilder: (context, index) {
                if (index == widget.last && widget.lists.length > widget.last) {
                  return GestureDetector(
                    onTap: () => widget.onClicked(widget.showIcon),
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKP3n3G2wMA5Fab1W04OuTwQp2Yx0_KXPlVg&usqp=CAU",
                            width: 70,
                            height: 40,
                            alignment: Alignment.center,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                            child: Text(
                              'More',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  final listItemIndex = index < widget.last ? index : index - 1;
                  final bool onTapped = widget.optionIndex == listItemIndex;
                  return GestureDetector(
                    onTap: () => widget.onItemSelect(listItemIndex),
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(7),
                      elevation: onTapped ? 4 : 1,
                      shape: RoundedRectangleBorder(
                        side: onTapped
                            ? const BorderSide(
                                color: Colors.purpleAccent, width: 2)
                            : BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(
                            onTapped
                                ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ3cGUxcNAw7jfPZiWRRTO00SQpmMPGtQf4G8kbC8HoZVCBDqkoo9LZAO0UZbKAd5szDE&usqp=CAU'
                                : widget.lists[listItemIndex].icon,
                            width: 70,
                            height: 40,
                            alignment: Alignment.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                            child: Text(
                              widget.lists[listItemIndex].name,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }),
        ),
      ],
    );
  }
}
