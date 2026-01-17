import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Draws a [Widget] that handles specific input features for a password value.
final class PasswordInput extends StatefulWidget {
  /// Input label.
  final String label;

  /// Whether the input should start hidden.
  final bool startHidden;

  /// Initial value.
  final String value;

  /// Event callback when the inner value has changed.
  final void Function(String newValue) onChanged;

  /// Creates a new instance.
  const PasswordInput({
    super.key,
    this.value = '',
    this.label = 'Password',
    this.startHidden = true,
    required this.onChanged,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

/// [State] class [PasswordInput].
final class _PasswordInputState extends State<PasswordInput> {
  late final TextEditingController editingCtrl = TextEditingController(
    text: widget.value,
  );

  /// Whether the current state is password hidden.
  late bool isPrivate = widget.startHidden;

  @override
  void didUpdateWidget(covariant PasswordInput oldWidget) {
    if (oldWidget.startHidden != widget.startHidden) {
      isPrivate = widget.startHidden;
    }

    if (oldWidget.value != widget.value) {
      editingCtrl.text = widget.value;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TextInput(
      label: widget.label,
      isPrivate: isPrivate,
      controller: editingCtrl,
      onChanged: widget.onChanged,
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
