import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart';

/// {widget} class.
///
/// Draws and handles a pagination handler [Widget] to simplify data paging selection options.
final class PaginationHandler extends StatefulWidget {
  /// Whether the [Widget] interactions must be disabled.
  final bool disabled;

  /// [Widget] pagination options.
  final PaginationData paginationData;

  /// Trigger method on select new [page] or [range] pages.
  final void Function(PaginationData paginationData) onChange;

  /// Creates a new [PaginationHandler] instance.
  const PaginationHandler({
    this.disabled = false,
    required this.onChange,
    required this.paginationData,
  });

  @override
  State<PaginationHandler> createState() => _PaginationState();
}

/// {state} class.
///
/// Handles the [State] for [PaginationHandler] {widget}.
final class _PaginationState extends State<PaginationHandler> with ThemingStateMixin<PaginationHandler> {
  /// Theme effect reference key.
  final UniqueKey themingRef = UniqueKey();

  /// {state} {theming} Theming options for application page.
  late ThemingData theming;

  /// {state} Current pagination options calculations.
  late PaginationData paginationData;

  @override
  void initState() {
    paginationData = widget.paginationData;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    theming = ThemingUtils.get<IThemeData>(context).page;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant PaginationHandler oldWidget) {
    if (widget.paginationData != paginationData) {
      paginationData = widget.paginationData;
    }

    super.didUpdateWidget(oldWidget);
  }

  /// {event}
  void onRangeChange(int newRange) {
    setState(() {
      paginationData = paginationData.clone(
        range: newRange,
      );
      widget.onChange(paginationData);
    });
  }

  /// {event}
  void onPageChange(int newPage) {
    setState(() {
      paginationData = paginationData.clone(
        page: newPage,
      );
      widget.onChange(paginationData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {
        boxConstraints = boxConstraints.boxed();

        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: boxConstraints.biggest.width,
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 12,
            children: <Widget>[
              /// --> Current data indicator
              ResponsiveWidget(
                onLarge: RichText(
                  text: TextSpan(
                    text: 'Showing ',
                    style: TextStyle(
                      color: theming.fore,
                      fontWeight: FontWeight.w100,
                      fontStyle: FontStyle.italic,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '(${paginationData.pageCount})',
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      const TextSpan(text: ' records from '),
                      TextSpan(
                        text: '(${paginationData.total})',
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                onSmall: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Showing',
                        style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 10,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' (${paginationData.pageCount})',
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'from',
                        style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 10,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' (${paginationData.total})',
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// --> Pagination controls
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 12,
                children: <Widget>[
                  /// --> Page range selector
                  DropUp<int>(
                    disabled: widget.disabled,
                    tooltip: 'Page range selection',
                    item: paginationData.range,
                    items: paginationData.ranges,
                    onChange: onRangeChange,
                  ),
                  // --> Page selector
                  DropUp<int>(
                    disabled: widget.disabled,
                    tooltip: 'Page selection',
                    item: paginationData.page,
                    items: List<int>.generate(
                      paginationData.pages,
                      (int i) => i + 1,
                    ),
                    onChange: onPageChange,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
