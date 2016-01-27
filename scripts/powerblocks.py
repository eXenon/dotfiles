import json
from colors import colors

class Block:
	def __init__(self, name):
		self.block = {"name": name,	
				"separator": False,
				"separator_block_width": -1,
				"block_width": 0,
				"border_left": 5,
				"border_right": 5,
				"min_width": 0,
				}
	
	def set_text(self, s):
		self.block["full_text"] = s
	
	def set_color(self, c):
		self.block["color"] = c
	
	def set_background(self, c):
		self.block["background"] = c

	def set_border(self, color, border_right=0, border_left=0, border_top=0, border_bottom=0):
		self.block["border"] = color
		self.block["border_right"] = border_right
		self.block["border_left"] = border_left
		self.block["border_top"] = border_top
		self.block["border_bottom"] = border_bottom
			
	def set_min_width(self, min_width):
		self.block["min_width"] = min_width
	
	def set_align(self, align):
		self.block["align"] = align

	def __getitem__(self, k):
		return self.block[k]

	def __setitem__(self, k, v):
		self.block[k] = v
	
	def to_json(self):
		return json.dumps(self.block)



class Header(Block):
	"""
	The block that makes the arrow for a powerblock block
	"""
	def __init__(self, name):
		super().__init__(name + "_header")
		self.set_text("\uE0B3")
		self.set_border(colors["background"]["default"])

	def update(self, next_body, prev_body):
		p = prev_body["background"]
		n = next_body["background"]
		if p == n:
			self.set_background(p)
			self.set_color(colors["text"]["default"])
			self.set_text("\uE0B3")
		else:
			self.set_background(n)
			self.set_color(p)
			self.set_text("\uE0B2")

class Powerblock:
	def __init__(self, name):
		self.body = Block(name)
		self.header = Header(name)
		self.meta = {"urgent": False, "hl": False}
		self.body.set_background(colors["background"]["default"])
		self.body.set_color(colors["text"]["default"])

	def set_urgent(self):
		self.meta["urgent"] = True
		self.body.set_background(colors["background"]["urgent"])
		self.body.set_color(colors["text"]["urgent"])

	def set_hl(self):
		self.meta["hl"] = True
		self.body.set_background(colors["background"]["hl"])
		self.body.set_color(colors["text"]["hl"])

	def set_text(self, text):
		self.body.set_text(text)

	def update(self, next_power_block):
		self.header.update(next_power_block.body, self.body)

	def to_json(self):
		return self.header.to_json() + "," + self.body.to_json()
