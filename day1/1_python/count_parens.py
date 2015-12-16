#!/usr/bin/env python3

with open("input.txt", "r") as f:
	lines = "".join(f.readlines())
	print(lines.count("(") - lines.count(")"))