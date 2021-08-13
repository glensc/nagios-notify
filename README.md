# Nagios Notify

The [nagios-notify] package is a template-based notify script for Nagios.

The templates can be easily edited in a text editor. You can change templates
without restarting Nagios. With advanced templates, you can send rich text
(even images) over jabber if you use nagios-notify-jabber. It depends only on
basic Unix utilities.

[nagios-notify]: https://github.com/glensc/nagios-notify

You should use this package because:

- the templates are easily edited in a text editor
- you won't be worried if the command definition contains shell syntax errors
  (which Nagios happily discards without any trace in logs :/)
- you can change templates without restarting Nagios
- with advanced templates, you can send rich-text (even images!) over jabber if
  you use nagios-notify-jabber
- minimal dependency (just coreutils and awk that you most likely already have
  installed)
