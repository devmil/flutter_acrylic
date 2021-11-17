library flutter_acrylic;

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

/// Platform channel name.
const _kChannelName = "com.alexmercerind/flutter_acrylic";

/// Initializes the plugin.
const _kInitialize = "Initialize";

/// Sets window effect.
const _kSetEffect = "SetEffect";

/// Hides window controls
const _kHideWindowControls = "HideWindowControls";

/// Shows window controls
const _kShowWindowControls = "ShowWindowControls";

/// Enters fullscreen.
const _kEnterFullscreen = "EnterFullscreen";

/// Exits fullscreen.
const _kExitFullscreen = "ExitFullscreen";

/// Gets the height of the titlebar.
const _kGetTitlebarHeight = "GetTitlebarHeight";

/// Overrides the brightness setting of the window (macOS only).
const _kOverrideMacOSBrightness = "OverrideMacOSBrightness";


/// (macOS only).
const _kSetDocumentEdited = "SetDocumentEdited";

/// (macOS only).
const _kSetDocumentNotEdited = "SetDocumentNotEdited";

/// (macOS only).
const _kSetRepresentedFile = "SetRepresentedFile";

/// (macOS only).
const _kSetRepresentedURL = "SetRepresentedURL";

/// (macOS only).
const _kHideTitlebar = "HideTitlebar";

/// (macOS only).
const _kShowTitlebar = "ShowTitlebar";

/// (macOS only).
const _kMakeTitlebarTransparent = "MakeTitlebarTransparent";

/// (macOS only).
const _kMakeTitlebarOpaque = "MakeTitlebarOpaque";

/// (macOS only).
const _kEnableFullSizeContentView = "EnableFullSizeContentView";

/// (macOS only).
const _kDisableFullSizeContentView = "DisableFullSizeContentView";

/// (macOS only).
const _kZoomWindow = "ZoomWindow";

/// (macOS only).
const _kUnzoomWindow = "UnzoomWindow";

/// (macOS only).
const _kIsWindowZoomed = "IsWindowZoomed";

/// (macOS only).
const _kIsWindowFullscreened = "IsWindowFullscreened";

/// (macOS only).
const _kHideZoomButton = "HideZoomButton";

/// (macOS only).
const _kShowZoomButton = "ShowZoomButton";

/// (macOS only).
const _kHideMiniaturizeButton = "HideMiniaturizeButton";

/// (macOS only).
const _kShowMiniaturizeButton = "ShowMiniaturizeButton";

/// (macOS only).
const _kHideCloseButton = "HideCloseButton";

/// (macOS only).
const _kShowCloseButton = "ShowCloseButton";

/// (macOS only).
const _kEnableZoomButton = "EnableZoomButton";

/// (macOS only).
const _kDisableZoomButton = "DisableZoomButton";

/// (macOS only).
const _kEnableMiniaturizeButton = "EnableMiniaturizeButton";

/// (macOS only).
const _kDisableMiniaturizeButton = "DisableMiniaturizeButton";

/// (macOS only).
const _kEnableCloseButton = "EnableCloseButton";

/// (macOS only).
const _kDisableCloseButton = "DisableCloseButton";

/// (macOS only).
const _kIsWindowInLiveResize = "IsWindowInLiveResize";

/// (macOS only).
const _kSetWindowAlphaValue = "SetWindowAlphaValue";

/// (macOS only).
const _kMakeWindowRestorable = "MakeWindowRestorable";

/// (macOS only).
const _kMakeWindowUnrestorable = "MakeWindowUnrestorable";

/// (macOS only).
const _kIsWindowVisible = "IsWindowVisible";


final MethodChannel _kChannel = const MethodChannel(_kChannelName);
final Completer<void> _kCompleter = new Completer<void>();

/// Available effects for the Flutter window.
enum WindowEffect {
  /// Default window background.
  /// Works on Windows & Linux.
  disabled,

  /// Solid colored window background.
  /// Works on Windows & Linux.
  solid,

  /// Transparent window background.
  /// Works on Windows & Linux.
  transparent,

  /// Aero glass effect.
  /// Windows Vista & Windows 7 like glossy blur effect.
  /// Works only on Windows.
  aero,

  /// Acrylic is a type of brush that creates a translucent texture. You can apply acrylic to app surfaces to add depth and help establish a visual hierarchy.
  /// Works only on Windows 10 version 1803 or higher.
  acrylic,

  /// Mica is an opaque, dynamic material that incorporates theme and desktop wallpaper to paint the background of long-lived windows.
  /// Works only on Windows 11 or greater.
  mica,
  
  /// The material for a window’s titlebar.
  /// Works only on macOS.
  titlebar,
  
  /// The material used to indicate a selection.
  /// Works only on macOS.
  selection,
  
  /// The material for menus.
  /// Works only on macOS.
  menu,
  
  /// The material for the background of popover windows.
  /// Works only on macOS.
  popover,
  
  /// The material for the background of window sidebars.
  /// Works only on macOS.
  sidebar,
  
  /// The material for in-line header or footer views.
  /// Works only on macOS.
  headerView,
  
  /// The material for the background of sheet windows.
  /// Works only on macOS.
  sheet,
  
  /// The material for the background of opaque windows.
  /// Works only on macOS.
  windowBackground,
  
  /// The material for the background of heads-up display (HUD) windows.
  /// Works only on macOS.
  hudWindow,
  
  /// The material for the background of a full-screen modal interface.
  /// Works only on macOS.
  fullScreenUI,
  
  /// The material for the background of a tool tip.
  /// Works only on macOS.
  toolTip,
  
  /// The material for the background of opaque content.
  /// Works only on macOS.
  contentBackground,
  
  /// The material to show under a window's background.
  /// Works only on macOS.
  underWindowBackground,
  
  /// The material for the area behind the pages of a document.
  /// Works only on macOS.
  underPageBackground,
}

/// **Window**
///
/// Primary class to control Flutter instance window.
///
class Window {
  /// Initializes the [Window] class.
  ///
  /// _Example_
  /// ```dart
  /// Future<void> main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await Window.initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  static Future<void> initialize() async {
    await _kChannel.invokeMethod(_kInitialize);
    _kCompleter.complete();
  }

  /// Sets specified effect for the window.
  ///
  /// When using [WindowEffect.mica], [dark] argument can be used to switch between light or dark mode of Mica.
  ///
  /// When using [WindowEffect.acrylic], [WindowEffect.aero], [WindowEffect.disabled], [WindowEffect.solid] or [WindowEffect.transparent],
  /// [color] argument can be used to change the resulting tint (or color) of the window background.
  ///
  /// _Examples_
  ///
  /// ```dart
  /// await Window.setEffect(
  ///   effect: WindowEffect.acrylic,
  ///   color: Color(0xCC222222),
  /// );
  /// ```
  ///
  /// ```dart
  /// await Window.setEffect(
  ///   effect: WindowEffect.mica,
  ///   dark: true,
  /// );
  /// ```
  ///
  static Future<void> setEffect({
    required WindowEffect effect,
    Color color: Colors.transparent,
    bool dark: true,
  }) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(
      _kSetEffect,
      {
        'effect': effect.index,
        'color': {
          'R': color.red,
          'G': color.green,
          'B': color.blue,
          'A': color.alpha,
        },
        'dark': dark,
      },
    );
  }

  /// Hides window controls.
  static Future<void> hideWindowControls() async {
    await _kChannel.invokeMethod(_kHideWindowControls);
  }

  /// Shows window controls.
  static Future<void> showWindowControls() async {
    await _kChannel.invokeMethod(_kShowWindowControls);
  }

  /// Makes the Flutter window fullscreen.
  static Future<void> enterFullscreen() async {
    await _kChannel.invokeMethod(_kEnterFullscreen);
  }

  /// Restores the Flutter window back to normal from fullscreen mode.
  static Future<void> exitFullscreen() async {
    await _kChannel.invokeMethod(_kExitFullscreen);
  }
  
  /// Gets the height of the titlebar.
  /// This value is used to determine the [[TitlebarSafeArea]] widget.
  /// If the full-size content view is enabled, this value will be the height of the titlebar.
  /// If the full-size content view is disabled, this value will be 0.
  /// This value is only available on macOS.
  static Future<double> getTitlebarHeight() async {
    await _kCompleter.future;
    return await _kChannel.invokeMethod(_kGetTitlebarHeight);
  }
  
  /// Sets the document to be edited.
  /// This method is only available on macOS.
  static Future<void> setDocumentEdited(bool edited) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kSetDocumentEdited);
  }
  
  /// Sets the document to not be edited.
  /// This method is only available on macOS.
  static Future<void> setDocumentNotEdited() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kSetDocumentNotEdited);
  }
  
  /// Sets the represented file of the window.
  /// This method is only available on macOS.
  static Future<void> setRepresentedFilename(String filename) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kSetRepresentedFile, {
      'filename': filename,
    });
  }
  
  /// Sets the represented URL of the window.
  /// This method is only available on macOS.
  static Future<void> setRepresentedUrl(String url) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kSetRepresentedURL, {
      'url': url,
    });
  }
  
  /// Hides the titlebar of the window.
  /// This method is only available on macOS.
  static Future<void> hideTitlebar() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kHideTitlebar);
  }
  
  /// Shows the titlebar of the window.
  /// This method is only available on macOS.
  static Future<void> showTitlebar() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kShowTitlebar);
  }
  
  /// Makes the window's titlebar transparent.
  /// This method is only available on macOS.
  static Future<void> makeTitlebarTransparent() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kMakeTitlebarTransparent);
  }
  
  /// Makes the window's titlebar opaque.
  /// This method is only available on macOS.
  static Future<void> makeTitlebarOpaque() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kMakeTitlebarOpaque);
  }
  
  /// Enables the window's full-size content view.
  /// It is recommended to enable the full-size content view when making
  /// the titlebar transparent.
  /// This method is only available on macOS.
  static Future<void> enableFullSizeContentView() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kEnableFullSizeContentView);
  }
  
  /// Disables the window's full-size content view.
  /// This method is only available on macOS.
  static Future<void> disableFullSizeContentView() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kDisableFullSizeContentView);
  }
  
  /// Zooms the window.
  /// This method is only available on macOS.
  static Future<void> zoomWindow(double scale) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kZoomWindow);
  }
  
  /// Unzooms the window.
  /// This method is only available on macOS.
  static Future<void> unzoomWindow() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kUnzoomWindow);
  }
  
  /// Returns if the window is zoomed.
  /// This method is only available on macOS.
  static Future<bool> isWindowZoomed() async {
    await _kCompleter.future;
    return await _kChannel.invokeMethod(_kIsWindowZoomed);
  }
  
  /// Returns if the window is fullscreened.
  /// This method is only available on macOS.
  static Future<bool> isWindowFullscreened() async {
    await _kCompleter.future;
    return await _kChannel.invokeMethod(_kIsWindowFullscreened);
  }
  
  /// Hides the window's zoom button.
  /// This method is only available on macOS.
  static Future<void> hideZoomButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kHideZoomButton);
  }
  
  /// Shows the window's zoom button.
  /// The zoom button is visible by default.
  /// This method is only available on macOS.
  static Future<void> showZoomButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kShowZoomButton);
  }
  
  /// Hides the window's miniaturize button.
  /// This method is only available on macOS.
  static Future<void> hideMiniaturizeButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kHideMiniaturizeButton);
  }
  
  /// Shows the window's miniaturize button.
  /// The miniaturize button is visible by default.
  /// This method is only available on macOS.
  static Future<void> showMiniaturizeButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kShowMiniaturizeButton);
  }
  
  /// Hides the window's close button.
  /// This method is only available on macOS.
  static Future<void> hideCloseButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kHideCloseButton);
  }
  
  /// Shows the window's close button.
  /// The close button is visible by default.
  /// This method is only available on macOS.
  static Future<void> showCloseButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kShowCloseButton);
  }
  
  /// Enables the window's zoom button.
  /// The zoom button is enabled by default.
  /// This method is only available on macOS.
  static Future<void> enableZoomButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kEnableZoomButton);
  }
  
  /// Disables the window's zoom button.
  /// This method is only available on macOS.
  static Future<void> disableZoomButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kDisableZoomButton);
  }
  
  /// Enables the window's miniaturize button.
  /// The miniaturize button is enabled by default.
  /// This method is only available on macOS.
  static Future<void> enableMiniaturizeButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kEnableMiniaturizeButton);
  }
  
  /// Disables the window's miniaturize button.
  /// This method is only available on macOS.
  static Future<void> disableMiniaturizeButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kDisableMiniaturizeButton);
  }
  
  /// Enables the window's close button.
  /// The close button is enabled by default.
  /// This method is only available on macOS.
  static Future<void> enableCloseButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kEnableCloseButton);
  }
  
  /// Disables the window's close button.
  /// This method is only available on macOS.
  static Future<void> disableCloseButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kDisableCloseButton);
  }
  
  /// Gets whether the window is currently being resized by the user.
  /// This method is only available on macOS.
  static Future<bool> isWindowInLiveResize() async {
    await _kCompleter.future;
    return await _kChannel.invokeMethod(_kIsWindowInLiveResize);
  }
  
  /// Sets the window's alpha value.
  /// This method is only available on macOS.
  static Future<void> setWindowAlphaValue(double value) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kSetWindowAlphaValue, <String, dynamic>{
      'value': value,
    });
  }
  
  /// Makes the window restorable.
  /// If the window is restorable, its configuration will be preserved between
  /// application launches.
  /// This method is only available on macOS.
  static Future<void> makeWindowRestorable() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kMakeWindowRestorable);
  }
  
  /// Makes the window unrestorable.
  /// If the window is unrestorable, its configuration will be cleared between
  /// application launches.
  /// This method is only available on macOS.
  static Future<void> makeWindowUnrestorable() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(_kMakeWindowUnrestorable);
  }
  
  /// Gets if the window is visible.
  /// This method is only available on macOS.
  static Future<bool> isWindowVisible() async {
    await _kCompleter.future;
    return await _kChannel.invokeMethod(_kIsWindowVisible);
  }
  
  /// Overrides the brightness setting of the window (macOS only).
  static Future<void> overrideMacOSBrightness({
    required bool dark,
  }) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(
      _kOverrideMacOSBrightness,
      {
        'dark': dark,
      },
    );
  }
}
