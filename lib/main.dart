import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mydbtest/src/models/modal_fit.dart';
import 'package:mydbtest/src/models/palibook.dart';
import 'package:mydbtest/src/services/db_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbService = DatabaseService();
  static IndexedScrollController controller =
      IndexedScrollController(initialIndex: 1200);

  @override
  void dispose() {
    dbService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<List<PaliBook>>(
            future: dbService.getPali(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return IndexedListView.builder(
                controller: controller,
                itemBuilder: itemBuilder(context, snapshot),
              );
            }));
  }

  IndexedWidgetBuilderOrNull itemBuilder(
      BuildContext context, AsyncSnapshot snapshot) {
    return (BuildContext context, int index) {
      return SelectableText(
        snapshot.data![index].id.toString() + snapshot.data![index].pHTM,
        onTap: () {
          print(snapshot.data![index].pHTM);
        },
        onSelectionChanged: (TextSelection selection, cause) {
          String s = snapshot.data![index].pHTM;
          String wrd =
              s.substring(selection.baseOffset - 4, selection.extentOffset - 4);
          controller = IndexedScrollController(initialIndex: index);
          print('\n there was a selection $wrd \n');
          //Fluttertoast.showToast(msg: wrd);
          if (wrd.length > 2) {
            Map map2 = {'selectedword': wrd};
            showMaterialModalBottomSheet(
              expand: false,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => ModalFit(key: ValueKey(wrd)),
            );
          }
        },
        enableInteractiveSelection: true,
        style: TextStyle(fontSize: 15),
      );
    };
  }
}
