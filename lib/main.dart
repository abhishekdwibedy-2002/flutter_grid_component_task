import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:task_conponents/gridview_components.dart';
import 'package:task_conponents/list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Components Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List options = [];
  List tempOptions = [];
  // customize the more option where it will show
  int endList = 5;
  int? selectedIndex;
  int? flag;

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    print(data);
    setState(() {
      options = data["data"];
      tempOptions = List.from(options); // copy of original lists
    });
  }

  // Navigate To List View Page when more option is called
  // Handle The Options Selection that is selected in the list view.
  void navigateList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListOption(
          optionList: options,
          onOptionSelected: (index) {
            optionSelected(index);
          }, 
          showIcon: false,
        ),
      ),
    );
  }

  // Method to handle the selected option index from the list view.
  // If selected index more than end list then only replace and rebuild it.
  void optionSelected(int? index) {
    setState(() {
      selectedIndex = index;
      if (selectedIndex! >= endList) {
        tempOptions[0] = options[selectedIndex!];
        tempOptions[selectedIndex!] = options[0];
        flag = index;
        selectedIndex = 0;
      } else {
        tempOptions[0] = options[0];
      }
    });
  }

  // Method To handle the select item index inside the grid view
  void itemSelect(int index) {
    setState(() {
      // handle the temporary replacement of the selected option 
      //outside the grid show the first option itself in the grid
      if (flag != null) {
        tempOptions[0] = tempOptions[flag!];
        flag = null;
      }
      // handle the select and deselect grid
      if (selectedIndex == index) {
        selectedIndex = null;
      } else {
        selectedIndex = index;
      }
    });
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: GridViewWidget(
          lists: tempOptions,
          last: endList,
          onClicked: navigateList,
          optionIndex: selectedIndex,
          onItemSelect: itemSelect,
          title: 'What is this payment for ?',
        ),
      ),
    );
  }
}
