import 'bloc_base.dart';
import 'session_model.dart';
import 'log_manager.dart';

export 'session_model.dart';

class SessionBloc extends BlocBase<SessionModel> {

  final logger = LogManager.getLogger('SessionBloc');

  @override
  void dispose() {
    super.dispose();
  }

  void run() {
    logger.i('add session running');
    add(SessionRunning());
  }

  void finish() {
    logger.i('add session finish');
    add(SessionComplete());
  }

  void cancel() {
    logger.i('add session failed');
    add(SessionFailed());
  }
}