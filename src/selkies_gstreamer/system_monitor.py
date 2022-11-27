# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

import time
import psutil

import logging
logger = logging.getLogger("system_monitor")


class SystemMonitor:
    def __init__(self, period=1, enabled=True):
        self.period = period
        self.enabled = enabled
        self.running = False

        self.cpu_percent = 0
        self.mem_total = 0
        self.mem_used = 0

        self.on_timer = lambda: logger.warn(
            "unhandled on_timer")

    def start(self):
        self.running = True
        while self.running:
            if self.enabled:
                self.cpu_percent = psutil.cpu_percent()
                mem = psutil.virtual_memory()
                self.mem_total = mem.total
                self.mem_used = mem.used
                self.on_timer(time.time())
                time.sleep(self.period)

    def stop(self):
        self.running = False
