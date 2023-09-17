import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

class Debouncer {
  static EventTransformer<Event> debounce<Event>({
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    return (events, mapper) => events.debounce(duration).switchMap(mapper);
  }
}
