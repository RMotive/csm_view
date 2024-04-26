import 'package:csm_foundation_view/src/common/common_module.dart';
import 'package:flutter/material.dart';

typedef _Terraformer = CSMTerraformer;

/// Widget class for [CSMAdaptativeView].
///
/// Defines UI for a [CSMAdaptativeView] implementation.
///
/// [CSMAdaptativeView] concept: handle draw decission based on specific running plarform, specifying what to draw when
/// the device is a desktop, mobile, or web application.
final class CSMAdaptativeView extends StatelessWidget {
  /// [Widget] to draw when the running platform is desktop context.
  final Widget? onDesktop;

  /// [Widget] to draw when the running platform is mobile context.
  final Widget? onMobile;

  /// [Widget] to draw when the running platform is web browser context.
  final Widget? onBrowser;

  /// Generates a new [CSMAdaptativeView] context.
  const CSMAdaptativeView({
    super.key,
    this.onDesktop,
    this.onMobile,
    this.onBrowser,
  });

  @override
  Widget build(BuildContext context) {
    if (_Terraformer.isWeb && onBrowser == null || _Terraformer.isMobile && onMobile == null || _Terraformer.isDesktop && onDesktop == null) {
      return ErrorWidget("You're on ${_Terraformer.context.name} and the value provided is null");
    }

    if (_Terraformer.isWeb) return onBrowser as Widget;
    if (_Terraformer.isDesktop) return onDesktop as Widget;
    return onMobile as Widget;
  }
}
