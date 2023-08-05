import 'package:flutter/material.dart';

class MonthDayPicker extends StatefulWidget {
  final List<DateTime> list;
  final Function setInfo;
  const MonthDayPicker(this.list, {Key? key, required this.setInfo})
      : super(key: key);

  @override
  State<MonthDayPicker> createState() => _MonthDayPickerState();
}

class _MonthDayPickerState extends State<MonthDayPicker> {
  @override
  Widget build(BuildContext context) {
    // define item height
    double itemHeight = 30;
    var middleIndex =
        (widget.list.length / 2).floor(); // index of the middle item
    var scrollController = ScrollController(
      // if you want middle item to be pre-selected
      initialScrollOffset: middleIndex * itemHeight,
    );
    int numberOfItemsToBeVisible = 5;
    double pickerHeight = itemHeight * numberOfItemsToBeVisible;
    // or you can pass index of the item you want to be visible
    var selectedItem = ValueNotifier(widget.list[middleIndex]);
    // changing selected item on scroll
    scrollController.addListener(() {
      selectedItem.value =
          widget.list[(scrollController.offset / itemHeight).round()];
    });
    return Column(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Container(
                  height: itemHeight,
                  width: MediaQuery.of(context).size.width,
                  decoration: ShapeDecoration(
                    color: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            // picker
            SizedBox(
              height: pickerHeight,
              child: ListWheelScrollView(
                diameterRatio: 1.2,
                itemExtent: itemHeight,
                controller: scrollController,
                children: widget.list
                    .map(
                      (element) => Align(
                        alignment: Alignment.center,
                        child: Text('${element.month}월 ',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        // selected item
        ValueListenableBuilder(
          valueListenable: selectedItem,
          builder: (context, DateTime value, _) =>
              Text('selected year: ${value.month}'),
        ),
      ],
    );
  }
}
