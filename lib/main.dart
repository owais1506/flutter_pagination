import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(key: ObjectKey("value"),title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> data = [];
  int currentLength = 0;

  final int increment = 10;
  bool isLoading = false;

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  Future _loadMore() async {
    setState(() {
      isLoading = true;
    });

    // dummy delay
    await new Future.delayed(const Duration(seconds: 2));
    for (var i = currentLength; i <= currentLength + increment; i++) {
      data.add(i);
    }
    setState(() {
      isLoading = false;
      currentLength = data.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.green,
        ),
        // contents of the app goes here
        body:LazyLoadScrollView(
          isLoading: isLoading,
          onEndOfPage: () => _loadMore(),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, position) {
              return DemoItem(position);
            },
          ),
    )
    );
  }
}

class DemoItem extends StatelessWidget {
  final int positions;

  const DemoItem(
      this.positions, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.deepPurple,
                  height: 40.0,
                  width: 40.0,
                ),
                //SizedBox(width: 8.0),
                Text("Item $positions"),
              ],
            ),
            Text(
                "GeeksforGeeks.org was created with a goal "
                    "in mind to provide well written, well "
                    "thought and well explained solutions for selected"
                    " questions. The core team of five super geeks"
                    " constituting of technology lovers and computer"
                    " science enthusiasts have been constantly working"
                    " in this direction .",
            textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
