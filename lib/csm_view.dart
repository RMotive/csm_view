// ignore_for_file: directives_ordering

library;

//! Exporting modules
export 'src/view/_view_module.dart';
export 'src/theming/_theming_module.dart';
export 'src/routing/_routing_module.dart';

// --> Package proxies
export 'package:device_info_plus/device_info_plus.dart' show AndroidDeviceInfo, IosDeviceInfo, LinuxDeviceInfo, WindowsDeviceInfo, WebBrowserInfo, BaseDeviceInfo;

//! Exporting [View] modules
export 'src/view/sandbox/_sandbox_module.dart'; //* Sandbox Module 

//! --> Exporting modules
export 'src/core/_core_module.dart';
export 'src/dep_widgets/widgets_module.dart';
export 'src/abstractions/abstractions_module.dart';

//! --> Exporing [src]
export 'src/abstractions/bases/view_module_base.dart';

export 'src/abstractions/bases/view_page_base.dart';
export 'src/abstractions/interfaces/iview_page.dart';

export 'src/abstractions/bases/view_layout_base.dart';
export 'src/abstractions/interfaces/iview_layout.dart';

export 'src/core/extensions/mixins/console_mixin.dart';
export 'src/core/extensions/mixins/matching_mixin.dart';
export 'src/core/extensions/mixins/platform_mixin.dart';
export 'src/core/extensions/mixins/theming_mixin.dart';
export 'src/core/extensions/mixins/themin_state_mixin.dart';

export 'src/core/utils/injector_utils.dart';
export 'src/core/utils/theming_utils.dart';
export 'src/core/utils/comparisson_utils.dart';
export 'src/core/utils/console_utils.dart';

export 'src/core/tools/widget_responsiveness/responsiveness_ratio.dart';
export 'src/core/tools/widget_responsiveness/widget_responsiveness.dart';
export 'src/core/tools/widget_responsiveness/responsiveness_breakpoint.dart';
export 'src/core/tools/widget_responsiveness/responsiveness_breakpoint_value.dart';

//! --> Exporting [Widgets]
export 'src/dep_widgets/abstractions/bases/reactor_base.dart';
export 'src/dep_widgets/abstractions/interfaces/ireactor.dart';

export 'src/dep_widgets/abstractions/bases/reactive_widget_base.dart';
export 'src/dep_widgets/abstractions/interfaces/ireactive_widget.dart';

export 'src/dep_widgets/business_widgets/password_input.dart';

export 'src/dep_widgets/text_input.dart';
export 'src/dep_widgets/button_flat.dart';
export 'src/dep_widgets/bordered_box.dart';
export 'src/dep_widgets/pointer_area.dart';
export 'src/dep_widgets/theme_switcher.dart';
export 'src/dep_widgets/reactive_widget.dart';
export 'src/dep_widgets/loading_indicator.dart';
export 'src/dep_widgets/responsive_widget.dart';
export 'src/dep_widgets/async_widget/async_widget.dart';
export 'src/dep_widgets/message_widgets/message_widget.dart';
export 'src/dep_widgets/message_widgets/error_message_widget.dart';


//! --> Exporting [Landing]
export 'src/view/sandbox/abstractions/bases/package_sandbox_theme_base.dart';

export 'src/view/sandbox/abstractions/bases/package_sandbox_item_base.dart';
export 'src/view/sandbox/abstractions/interfaces/ipackage_sandbox_item.dart';

export 'src/view/sandbox/abstractions/bases/package_sandbox_view_base.dart';

export 'src/view/sandbox/package_sandbox_themes/package_sandbox_theme_dark.dart';
export 'src/view/sandbox/package_sandbox_themes/package_sandbox_theme_light.dart';

//! --> Exporting [Layouts]
export 'src/view/layouts/navigation_layout/navigation_layout.dart';
export 'src/view/layouts/category_layout/category_layout.dart';
export 'src/view/layouts/category_layout/category_layout_page.dart';