enum SessionModelState {
  none,
  running,
  complete,
  failed
}


abstract class SessionModel {
  final SessionModelState state;
  SessionModel(this.state);
}


class SessionNone extends SessionModel {
  SessionNone():super(SessionModelState.none);
}

class SessionRunning extends SessionModel {
  SessionRunning():super(SessionModelState.running);
}

class SessionComplete extends SessionModel {
  SessionComplete():super(SessionModelState.complete);
}

class SessionFailed extends SessionModel {
  SessionFailed():super(SessionModelState.failed);
}