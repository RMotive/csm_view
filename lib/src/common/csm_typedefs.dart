import 'dart:async';
import 'package:csm_view/src/router/router_module.dart';
import 'package:flutter/material.dart';

/// Type definition for the navigation state key.
typedef Navigation = GlobalKey<NavigatorState>;

/// Type definition for a [JSON] object.
typedef JObject = Map<String, dynamic>;

/// Type definition for a [JSON] entry.
typedef JEntry = MapEntry<String, dynamic>;

/// Type definition for [HTTP] transaction headers.
typedef CSMHeaders = Map<String, String>;

/// Type definition for [CSMPageBase] builder method.
typedef CSMPageBuild = CSMPageBase Function(BuildContext ctx, CSMRouterOutput output);

/// Type definition for [CSMLayoutBase] builder method.
typedef CSMLayoutBuild = CSMLayoutBase Function(BuildContext ctx, CSMRouterOutput output, Widget page);

/// Type definition for [CSMRouter] redirection calculation.
typedef CSMRedirection = FutureOr<CSMRouteOptions?> Function(BuildContext ctx, CSMRouterOutput output);
