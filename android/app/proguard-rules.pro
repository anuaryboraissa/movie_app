# Keep Flutter related classes and methods
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.** { *; }

# Keep all annotations
-keepattributes *Annotation*

# Keep classes used by Flutter plugins
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.common.** { *; }
