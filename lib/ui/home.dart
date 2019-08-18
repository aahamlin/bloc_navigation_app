import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bloc_navigation_app/ui/bloc_listener.dart';
import 'package:bloc_navigation_app/core/session_bloc.dart';
import 'package:bloc_navigation_app/core/session_model.dart';
import 'package:bloc_navigation_app/core/log_manager.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final SessionBloc bloc = Provider.of<SessionBloc>(context);

    var logger = LogManager.getLogger('HomeScreen');
    logger.d('Building home screen');

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocListener<SessionBloc, SessionModel>(
        //key: GlobalKey(debugLabel: 'HomeScreenBlocListener'),
        bloc: bloc,
        listener: (context, state) {
          if (state is SessionRunning) {
            Navigator.pushNamed(context, '/running');
          }
          else if (state is SessionComplete) {
            final snackbar = SnackBar(content: Text('Session completed!'));
            Scaffold.of(context).showSnackBar(snackbar);
          }
          else if(state is SessionFailed) {
            final snackbar = SnackBar(content: Text('Session canceled.'));
            Scaffold.of(context).showSnackBar(snackbar);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Home page content'),
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  Provider.of<SessionBloc>(context).run();
                },
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 18.0)
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}