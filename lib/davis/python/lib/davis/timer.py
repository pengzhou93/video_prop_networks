#!/usr/bin/env python

# ----------------------------------------------------------------------------
# A Benchmark Dataset and Evaluation Methodology for Video Object Segmentation
#-----------------------------------------------------------------------------
# Copyright (c) 2016 Federico Perazzi
# Licensed under the BSD License [see LICENSE for details]
# Written by Federico Perazzi
# ----------------------------------------------------------------------------

"""
	 A simple wrapper to the built-in python timer.
"""

import time
from davis import log

class Timer(object):
	"""docstring for Timer"""
	def __init__(self):
		super(Timer, self).__init__()
		self._start = None

	def tic(self):
		self._start = time.time()
		return self

	def toc(self):
		assert self._start != None,\
				'Timer uninitialized. Call "toc()" first.'
		return time.time() - self._start

