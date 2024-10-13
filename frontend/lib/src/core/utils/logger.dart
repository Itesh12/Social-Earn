import 'package:logger/logger.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(),
  filter: MyFilter(),
);

final Logger loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
  filter: MyFilter(),
);

class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}
