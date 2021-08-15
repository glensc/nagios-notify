#!/usr/bin/env python3
import base64
import os
import sys
from datetime import datetime
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
        env.filters["timestamp_date"] = self.timestamp_date
        env.filters["encode_mime_header"] = self.encode_mime_header

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

    @staticmethod
    def timestamp_date(timestamp: str):
        return datetime.fromtimestamp(int(timestamp)).strftime("%Y-%m-%d %H:%M:%S")

    @staticmethod
    def encode_mime_header(data: str, charset: str = "utf-8"):
        """
        Encode email header as rfc2047 (using base64 encoding)
        """
        encoded = base64.b64encode(data.encode(charset)).decode("ascii")

        return f"=?{charset}?b?{encoded}?="


if not len(sys.argv) > 1:
    print(f"Usage: {sys.executable} template_file.tmpl")
    sys.exit(2)

template = sys.argv[1]
notify = NagiosNotify()
print(notify.render(template))
