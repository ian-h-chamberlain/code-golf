# stderr with colors is nice, but colorized tables in stdout are hard to read,
# so we "clean up" the output with this hook when printing anything.
#
# Users can still call `print` explicitly if they want colors, but it seems unlikely
# any holes exist where that would be desirable and omitting `print` could improve score
$env.config.hooks.display_output = {
  default "" | table | into string | ansi strip
}
