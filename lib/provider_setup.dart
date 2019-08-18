import 'package:provider/provider.dart';

import 'core/session_bloc.dart';

List<SingleChildCloneableWidget> providers = [
  Provider<SessionBloc>.value(value: SessionBloc()),
];