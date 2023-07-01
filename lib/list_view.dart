import 'package:flutter/material.dart';

class ListOption extends StatefulWidget {
  const ListOption({
    super.key,
    required this.optionList,
    required this.onOptionSelected,
    required this.showIcon,
  });
  final List optionList;
  final Function(int?) onOptionSelected;
  final bool showIcon;

  @override
  State<ListOption> createState() => _ListOptionState();
}

class _ListOptionState extends State<ListOption> {
  int? selectedOptions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Select Option'),
      ),
      body: ListView.builder(
        itemCount: widget.optionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: widget.showIcon
                ? Image.network(
                    widget.optionList[index]["icon"],
                    width: 70,
                    height: 40,
                    alignment: Alignment.center,
                  )
                : null,
            title: Row(
              children: [
                const SizedBox(
                  height: 35,
                ),
                if (widget.showIcon)
                  const SizedBox(
                    width: 10,
                  ),
                Text(
                  widget.optionList[index]["name"],
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            trailing: Radio<int>(
              value: index,
              groupValue: selectedOptions,
              onChanged: (int? value) {
                setState(() {
                  selectedOptions = index;
                });
                widget.onOptionSelected(value);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
