part of '../category_layout.dart';

final class _CategoryLayoutMessenger extends StatefulWidget {
  /// Creates a new [_CategoryLayoutMessenger] instance.
  const _CategoryLayoutMessenger({super.key});

  @override
  State<_CategoryLayoutMessenger> createState() => CategoryLayoutMessengerState();
}

/// Handles [State] for [_CategoryLayoutMessenger].
final class CategoryLayoutMessengerState extends State<_CategoryLayoutMessenger> {
  /// {state} current messages being shown.
  final List<UserFeedback> _messageBag = <UserFeedback>[];

  /// Pushes a new [message] to be shown to the user at the current stack.
  void pushMessage(UserFeedback message) {
    setState(() {
      _messageBag.add(message);
    });
  }

  /// Pushes a new collection of [messages] to be shown to the user at the current stack.
  void pushMessages(List<UserFeedback> messages) {
    setState(() {
      _messageBag.addAll(messages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        16.0,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              spacing: 8,
              children: <Widget>[
                for (UserFeedback userFeedback in _messageBag)
                  _MessageChip(
                    key: ValueKey<int>(userFeedback.hashCode),
                    messageData: userFeedback,
                    onDismiss: () {
                      setState(() {
                        _messageBag.remove(userFeedback);
                      });
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
