#!/usr/bin/env python3
import os
import sys
from functools import cached_property

from jinja2 import Environment, FileSystemLoader, select_autoescape


class NagiosNotify:
    template_dir = "templates"

    @cached_property
    def env(self):
        env = Environment(
            loader=FileSystemLoader(self.template_dir),
            autoescape=select_autoescape()
        )
        return env

    @cached_property
    def variables(self):
        env = dict()
        for name, value in os.environ.items():
            if not name.startswith("NAGIOS_"):
                continue
            name = name.removeprefix("NAGIOS_")
            env[name] = value
        return env

    def get_template(self, filename: str):
        return self.env.get_template(filename)

    def render(self, filename: str):
        tpl = self.get_template(filename)

        return tpl.render(self.variables)


if not len(sys.argv) > 1:
    print(f"Usage: {sys.executable} template_file.tmpl")
    sys.exit(2)

template = sys.argv[1]
notify = NagiosNotify()
print(notify.render(template))
