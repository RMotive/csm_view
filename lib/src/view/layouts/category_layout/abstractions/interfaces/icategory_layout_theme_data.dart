import 'package:csm_view/csm_view.dart';

/// Represents a themed data that uses the { CSM } foundation { Category Layout }.
abstract interface class ICategoryLayoutThemeData implements IThemeData {
  /// Stores the [CategoryLayout] page actions ribbon action button theming.
  final StatefulControlThemeData<ControlThemeData> categoryLayoutRibbonActionButton;

  /// Creates a new instance.
  const ICategoryLayoutThemeData(this.categoryLayoutRibbonActionButton);
}
