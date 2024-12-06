import 'package:cat_trivia/bloc/cat_fact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
   HistoryPage({super.key,required this.catFactBloc});

  CatFactBloc catFactBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatFactBloc, CatFactState>(
      bloc: catFactBloc..add(GetHistoryFacts()),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView.builder(
            itemCount: state.list.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date/Time Text
                      Text(
                        DateFormat('dd-MM-yyyy').format(DateTime.parse(state.list[index].createdAt ?? "")),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 8),
                      // Description Text
                      Text(
                        state.list[index].text??"",
                        maxLines: 5,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
