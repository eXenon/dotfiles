#!/usr/bin/env python
import os
import sys
import subprocess
import json

def write(message):
  sys.stdout.write(message + '\n')
  sys.stdout.flush()

def read():
  try:
    line = sys.stdin.readline().strip()
    if not line:
      sys.exit(3)
    return line
  except KeyboardInterrupt:
    sys.exit()

def run(command):
  return subprocess.Popen(command, shell = True, stdout = subprocess.PIPE)

if __name__ == '__main__':
  write('{ "version": 1, "stop_signal": 10, "cont_signal": 12, "click_events": true }')
  write('[[]')

  os.system('python3 ~/.config/scripts/i3bar.py &')

  while True:

    line, prefix = read(), ''
    if line.startswith(','):
      line, prefix = line[1:], ','

    try:
      parsed = json.loads(line)
    except:
      continue

    x, y = parsed['x'], parsed['y']
    module = parsed['name']
    button = int(parsed['button'])

    try:
        with open('/tmp/i3bar.log', 'a') as f:
            f.write(str(module) + '\n')
            f.write(str(button) + '\n')
    except Exception as e:
        with open('/tmp/i3bar.log', 'w') as f:
            f.write(str(e))

    try:
      if module == 'calendar' and button == 1:
        run('gsimplecal')
      elif module == 'volume':
        if button == 1:
          os.system('$HOME/.config/scripts/volume_control.py up 10')
        elif button == 3:
          os.system('$HOME/.config/scripts/volume_control.py down 10')
        elif button == 4:
          os.system('$HOME/.config/scripts/volume_control.py up 1')
        elif button == 5:
          os.system('$HOME/.config/scripts/volume_control.py down 1')
      elif module == 'toggle-volume' and button == 1:
        run('$HOME/.config/scripts/volume_control.py toggle')
      elif module == 'keyboard' and button == 1:
        if not os.path.isfile('/tmp/bepo'):
          run('setxkbmap fr bepo ; touch /tmp/bepo ; rm -f /tmp/azerty')
        else:
          run('setxkbmap fr ; touch /tmp/azert ; rm -f /tmp/bepo')
    except:
      pass
