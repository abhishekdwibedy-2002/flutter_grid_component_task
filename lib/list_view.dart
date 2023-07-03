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
  List filteredOptions = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredOptions = widget.optionList;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void runFilter(String searchKeyword) {
    List results = [];
    if (searchKeyword.isEmpty) {
      results = widget.optionList;
    } else {
      results = widget.optionList.where((element) {
        final name = element.name.toLowerCase();
        return name.contains(searchKeyword.toLowerCase());
      }).toList();
    }
    // refresh the UI
    setState(() {
      filteredOptions = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          padding: EdgeInsets.zero,
        ),
        titleSpacing: 1,
        title: const Text('Choose category'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: searchController,
              onChanged: runFilter,
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search_sharp),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredOptions.length,
                itemBuilder: (context, index) {
                  final originalIndex =
                      widget.optionList.indexOf(filteredOptions[index]);
                  final isSelected = selectedOptions == originalIndex;
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color.fromARGB(44, 0, 0, 0)),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          selectedOptions = originalIndex;
                        });
                      },
                      leading: widget.showIcon
                          ? Image.network(
                              widget.optionList[originalIndex].icon,
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                            )
                          : null,
                      title: Row(
                        children: [
                          if (widget.showIcon)
                            const SizedBox(
                              width: 5,
                            ),
                          Text(
                            widget.optionList[originalIndex].name,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      trailing: Radio<int>(
                        value: originalIndex,
                        groupValue: selectedOptions,
                        onChanged: (int? value) {
                          setState(() {
                            selectedOptions = originalIndex;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  widget.onOptionSelected(selectedOptions);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: const Color.fromARGB(255, 122, 44, 195),
                    foregroundColor: Colors.white),
                child: const Text('Finish'))
          ],
        ),
      ),
    );
  }
}
