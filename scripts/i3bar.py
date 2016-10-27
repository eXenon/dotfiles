#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import re
import sys
import time
import basiciw
import datetime
import netifaces

from jsonpath_rw import jsonpath, parse

import volume_control
import executor
from colors import colors
from powerblocks import Powerblock

#########################################
### MISC ################################
#########################################

CPU_CACHE_LEN = 3
GRAPHBARS = " ▁▂▃▄▅▆▇█"
WEATHER = {'sunny': '☀',
           'cloudy': '☁',
           'low_rain': '☂',
           'high_rain': '☔',
           'thunder': '⛈',
           'sun_cloudy': '⛅',
           'snow': '☃'
          } 


def to_graph_bar(val, max_val, min_val=0):
    """ Return the graphbar for a value, given the min and max of the desired scale. """
    if max_val == min_val:
        return GRAPHBARS[0]
    min_graph, max_graph = 0, len(GRAPHBARS) - 1
    graph_index = val * (min_graph - max_graph) / (min_val - max_val) + (max_val*min_graph - min_val*max_graph) / (max_val - min_val)
    graph_index = int(graph_index)
    graph_index = min(max(graph_index, min_graph), max_graph)
    return GRAPHBARS[graph_index]

def blockify_active_window():
  """ Print the currently active window (or 'none'). """

  active_window, return_code = executor.run('xdotool getactivewindow getwindowname')
  if return_code != 0:
    return None
  if len(active_window) > 100:
    active_window = active_window[:80] + '...' + active_window[-20:]

  block = Powerblock('active-window')
  block.set_text(active_window)

  return block

def blockify_volume():
  """ Print the current volume. """

  block = Powerblock('volume')

  status = volume_control.status()
  if status == "on":
    volume = int(volume_control.get_volume())
    block.set_text('🔊  ' + str(volume) + '%')

  else:
    block.set_text('🔇')
    #block.set_urgent()

  return block


#########################################
### HARDWARE ############################
#########################################

def blockify_battery():
  """ Print the current battery level. """

  block = Powerblock('battery')

  acpi = executor.run('acpi -b')[0]
  battery = re.search('\d*%', acpi).group(0)
  battery_int = int(battery[:-1])
  is_charging = not bool(re.search('Discharging', acpi))

  if not is_charging:
      block.set_text('🔋  ' + battery)
  else:
      block.set_text('⚡  ' + battery)
  if battery_int < 40 and not is_charging:
    block.set_hl()
  elif battery_int < 20 and not is_charging:
    block.set_urgent()


  return block

def blockify_cpu(cache=[]):
  """ Print the CPU load average and temperature """
  
  block = Powerblock("cpu")

  cpuload = executor.run("uptime | awk -F'[a-z]:' '{ print $2}'")[0]
  oneminload = float(cpuload.split(",")[0] + "." + cpuload.split(",")[1])
  #cputemp = executor.run("cat /sys/class/thermal/thermal_zone7/temp")[0]
  #temp = int(cputemp) / 1000
  cache.append(oneminload)
  if len(cache) > CPU_CACHE_LEN:
      cache.pop(0)
  
  #if oneminload > 3 or temp > 80:
  if oneminload > 4:
    block.set_urgent()

  txt = str(cache[-1]) + "".join([to_graph_bar(l, 4) for l in cache]) + " " * (CPU_CACHE_LEN - len(cache))
  block.set_text(txt)

  #block.set_text(str(oneminload) + "/" + str(temp))
  return block

#########################################
### NETWORK #############################
#########################################

def blockify_internet():
  """ Prints primary IP and ping time to 8.8.8.8.
      Alerts when ping is high or IP not found.
  """
  block = Powerblock("internet")

  pingtime = executor.run("fping -C 1 -t 400 8.8.8.8")[0]
  ip = executor.run("ip a | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'")[0]
  if len(ip) < 4:
    block.set_urgent()
    block.set_text("NO IP")
  else:
    if len(pingtime) < 4:
      block.set_text(ip + " >400 ms")
      block.set_hl()
    else:
      pingtime = float(pingtime.split(" ")[5])
      if pingtime > 500:
        block.set_hl()
      elif pingtime > 1000:
        block.set_urgent()
      block.set_text(ip + " " + str(pingtime) + " ms")
  
  return block

def blockify_wifi():
  """ Prints information about the connected wifi. """

  block = Powerblock('network')
  interface = "wlx48ee0cf2d8fe"
  try:
    with open('/sys/class/net/{}/operstate'.format(interface)) as operstate:
      status = operstate.read().strip()
  except:
    block.set_text("No wifi adapter")
    block.set_hl()
    return block 

  info = basiciw.iwinfo(interface)
  if len(info['essid']) > 2:
    block.set_text(info['essid'])
  else:
    block.set_text("Wifi disc.")
    block.set_hl()

  return block

# TODO combine with wifi code
# TODO if ethernet is there but not connected, the i3bar disappears :(
def blockify_ethernet():
  """ Prints information about the connected ethernet. """

  interface = "eth0"
  try:
    with open('/sys/class/net/{}/operstate'.format(interface)) as operstate:
      status = operstate.read().strip()
  except:
    return None  
  if status != 'up':
    return None

  block = Powerblock('network')
  block.set_text(interface + ' @ ' + netifaces.ifaddresses(interface)[netifaces.AF_INET][0]['addr'])

  return block


#########################################
### TIME ################################
#########################################

def blockify_date():
  """ Prints the date and time. """

  now = datetime.datetime.now()

  calendar = Powerblock('calendar')
  calendar.set_text(now.strftime('%a., %d. %b. %Y %H:%M'))
  return calendar

def blockify_time():
  """ Prints the time. """

  now = datetime.datetime.now()

  clock = Powerblock('clock')
  clock.set_text(now.strftime('%H:%M'))
  return clock

#########################################
### MAIN ################################
#########################################

if __name__ == '__main__':
  os.nice(19)
  while True:
    blocks = [
      blockify_active_window(),
      blockify_volume(),
      blockify_battery(),
      blockify_wifi(),
      blockify_internet(),
      blockify_cpu(),
      blockify_date(),
    ]

    blocks = list(filter(lambda x:x!= None, blocks))
    for i in range(len(blocks)-1, 0, -1):
      blocks[i].update(blocks[i-1])

    json = ",".join(block.to_json() for block in blocks if block)

    sys.stdout.write(",[ " + json + " ]")
    sys.stdout.flush()
    
    time.sleep(2)
