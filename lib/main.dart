import 'package:cat_trivia/bloc/cat_fact_bloc.dart';
import 'package:cat_trivia/ui/history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

Future<void> main() async{
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final bloc = CatFactBloc();
  late Widget image;

  @override
  void initState() {
    super.initState();
    image = Image.network(
      "https://cataas.com/cat",
      width: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        }
      },
    );
  }

  void updateImage() {
    setState(() {
      image = Image.network(
        "https://cataas.com/cat?${DateTime.now().millisecondsSinceEpoch}",
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(CatFactLoaded()),
      child: Scaffold(
        floatingActionButton: Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  bloc.add(CatFactLoaded());
                  updateImage();
                },
                child: Text('Another Fact!'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HistoryPage(catFactBloc: bloc)),
                  );
                },
                child: Text('Fact History'),
              ),
            ],
          ),
        ),

        appBar: AppBar(title: Text('Cat Trivia')),
        body: BlocBuilder<CatFactBloc, CatFactState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 300,
                        child: image,
                      ),
                      SizedBox(height: 10),
                      Text(state.model?.text ?? "", textAlign: TextAlign.center),
                      state.model?.createdAt != null
                          ? Text(
                              "Date: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(state.model?.createdAt ?? ""))}",
                              style: TextStyle(fontSize: 12),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
