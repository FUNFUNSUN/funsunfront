import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.setInfo,
    required this.defaultDate,
  }) : super(key: key);
  final Function setInfo;

  final DateTime defaultDate;
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedDate = widget.defaultDate;
      selectedDate = DateTime(2000, selectedDate.month, selectedDate.day);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: 600,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              height: 100,
              width: 300,
              child: ScrollDatePicker(
                selectedDate: selectedDate,
                locale: const Locale('ko'),
                scrollViewOptions: const DatePickerScrollViewOptions(
                    year: ScrollViewDetailOptions(
                      label: '년',
                      margin: EdgeInsets.only(right: 40),
                    ),
                    month: ScrollViewDetailOptions(
                      label: '월',
                      margin: EdgeInsets.only(right: 40),
                    ),
                    day: ScrollViewDetailOptions(
                      label: '일',
                    )),
                onDateTimeChanged: (DateTime value) {
                  setState(() {
                    selectedDate = value;
                  });
                  widget.setInfo(selectedDate);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
