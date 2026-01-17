import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Draws a [Widget] that handles specific input features for a password value.
final class PasswordInput extends StatefulWidget {
  /// Input label.
  final String label;

  /// Whether the input should start hidden.
  final bool startHidden;

  /// Creates a new instance.
  const PasswordInput({
    super.key,
    this.label = 'Password',
    this.startHidden = true,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

/// [State] class [PasswordInput].
final class _PasswordInputState extends State<PasswordInput> {
  /// Whether the current state is password hidden.
  late bool isPrivate = widget.startHidden;

  @override
  void didUpdateWidget(covariant PasswordInput oldWidget) {
    if (oldWidget.startHidden != widget.startHidden) {
      isPrivate = widget.startHidden;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TextInput(
      label: widget.label,
      isPrivate: isPrivate,
      suffixIcon: IconButton(
        icon: Icon(
          isPrivate ? Icons.visibility : Icons.visibility_off,
          size: 24,
        ),
        onPressed: () {
          setState(() {
            isPrivate = !isPrivate;
          });
        },
      ),
    );
  }
}
