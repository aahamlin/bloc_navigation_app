import 'package:logger/logger.dart';
import 'package:bloc_navigation_app/core/database.dart';

export 'package:logger/logger.dart';

class NamedPrinter extends LogPrinter {
  final String name;
  final _dbMgr = DBProvider();

  static final logLevelInt = {
    Level.verbose: 0,
    Level.debug: 1,
    Level.info: 2,
    Level.warning: 3,
    Level.error: 4,
    Level.wtf: 5,
  };

  static final logLevelStr = {
    Level.verbose: 'VERBOSE',
    Level.debug: 'DEBUG',
    Level.info: 'INFO',
    Level.warning: 'WARN',
    Level.error: 'ERROR',
    Level.wtf: 'WTF',
  };

  NamedPrinter(this.name);

  @override
  void log(LogEvent event) {
    var time = DateTime.now();
    var msg = '$name ${event.message}';
    println('${time.toLocal().toIso8601String()} [${logLevelStr[event.level]}] $msg');
    _dbMgr.insertLog(logLevelInt[event.level], msg, time.millisecondsSinceEpoch);
  }

}

class LogManager {
  
  static final Map<String, Logger> _cache = {};

  static Logger getLogger(String name) {

    if (_cache.containsKey(name)) {
      return _cache[name];
    }
    else {
      final logger = Logger(
          printer: NamedPrinter(name),
      );
      _cache[name] = logger;
      return logger;
    }

  }
}