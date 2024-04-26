import 'package:flutter/material.dart';

/// Widget class for [CSMTable].
///
/// Defines UI for a [CSMTable] implementation.
///
/// [TData] - The type of each data entry that the table will draw.
///
/// [CSMTable] concept: draws a standard base UI for a data table.
final class CSMTable<TData> extends StatelessWidget {
  /// List of labels to display for each table column.
  final List<String> headers;

  /// The collection of data to display in each row.
  final List<TData> data;

  /// Whter the table state is loading, will display a loading progress indicator.
  final bool isLoading;

  /// How the header cell should be built.
  final Widget Function(String header) buildHeaderCell;

  /// A custom Widget to display when the [data] provided is empty.
  final Widget Function()? onEmpty;

  /// Generates a new [CSMTable] widget.
  const CSMTable({
    super.key,
    this.data = const <Never>[],
    this.isLoading = false,
    this.onEmpty,
    required this.buildHeaderCell,
    required this.headers,
  });

  @override
  Widget build(BuildContext context) {
    assert(headers.isNotEmpty, 'Table headers mustn\'t be empty');

    return LayoutBuilder(
      builder: (_, BoxConstraints constrains) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: IntrinsicWidth(
            child: Column(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constrains.maxWidth,
                  ),
                  child: Table(
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          for (String header in headers)
                            buildHeaderCell(
                              header,
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: (data.isEmpty && (onEmpty != null)),
                  child: onEmpty?.call() ?? const SizedBox(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
