import 'package:colorGenerator/bloc/change_color_bloc.dart';
import 'package:colorGenerator/services/background_color_service.dart';
import 'package:colorGenerator/services/text_color_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  ChangeColorBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ChangeColorBloc(BackgroundColorService(), TextColorService());
    _bloc.generateBackgroundColor();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: StreamBuilder<ChangeColorState>(
          initialData: _bloc.currentState,
          stream: _bloc.stateStream,
          builder: (BuildContext context, AsyncSnapshot<ChangeColorState> snapshot) {
            if(snapshot?.data != null && snapshot.data.isComplete) {
            return GestureDetector(
              onTap: () => _bloc.generateBackgroundColor(),
              child: Container(
                color: snapshot.data.backgroundColor,
                child: Center(
                    child:
                    Text('Hi, There!!!', style: TextStyle(
                      fontSize: 32,
                      color: snapshot.data.textColor
                    ),)
                ),
              ),
            );
            } else {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            }

          }
        ),
    );
  }

}