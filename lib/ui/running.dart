import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bloc_navigation_app/core/session_bloc.dart';
import 'package:bloc_navigation_app/core/session_model.dart';
import 'package:bloc_navigation_app/ui/bloc_listener.dart';
import 'package:bloc_navigation_app/core/log_manager.dart';

class RunningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SessionBloc bloc = Provider.of<SessionBloc>(context);
    var logger = LogManager.getLogger('RunningScreen');
    logger.d('Building running screen');

    return Scaffold(
      appBar: AppBar(
        title: Text('Running'),
      ),
      body: WillPopScope(
        onWillPop: () {
          bloc.cancel();
          return Future.value(true);
        },
        child: BlocListener<SessionBloc, SessionModel>(
          //key: GlobalKey(debugLabel: "RunningScreenBlocListener"),
          bloc: bloc,
          listener: (context, state) {
              if (state is SessionComplete) {
                Navigator.pushReplacementNamed(context, '/complete');
              }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Running page content'),
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
    //                Navigator.pushReplacementNamed(context, '/complete');
                    Provider.of<SessionBloc>(context).finish();
                  },
                  child: const Text(
                      'Finish',
                      style: TextStyle(fontSize: 18.0)
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

}