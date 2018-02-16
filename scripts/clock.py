"""French fuzzy clock script.
"""

import math
import click
from datetime import datetime
from num2words import num2words

def parse_time(ctx, param, value):
    if not value:
        return None
    try:
        t = datetime.strptime(value, "%H:%M")
        return t.hour + t.minute / 60
    except Exception as e:
        raise click.BadParameter('Could not parse time.')

def i18n(n, unit):
    if unit == "hour":
        if n == 0:
            return "minuit"
        elif n == 12:
            return "midi"
        elif n == 1:
            return "une heure"
        else:
            return "{} heure".format(num2words(n, lang="fr"))
    elif unit == "minute":
        if n == 0:
            return ""
        else:
            return "{}".format(num2words(n, lang="fr"))
    return "{} {}".format(num2words(n, lang="fr"), unit)

def clock(degree, force_now=None):
    """
    Degrees of precision :
    - 0 : 5 minutes precision
    - 1 : 15 minutes preceision
    - 2 : 30 minutes precision
    - 3 : 1 hour precision
    """
    now = datetime.now().hour + (datetime.now().minute / 60)
    if force_now:
        now = force_now
    if degree == 3:
        return i18n(round(now), "hour")
    elif degree == 2:
        rounded_time = round(now * 2) / 2
        hours, minutes = math.floor(rounded_time), round((rounded_time - math.floor(rounded_time))*60)
        return "{} {}".format(i18n(hours, "hour"), i18n(minutes, "minute"))
    elif degree == 1:
        rounded_time = round(now * 4) / 4
        hours, minutes = math.floor(rounded_time), round((rounded_time - math.floor(rounded_time))*60)
        return "{} {}".format(i18n(hours, "hour"), i18n(minutes, "minute"))

@click.command()
@click.option('--degree', default="1", help="Degree of precision, 0 for most precise, 3 for least.",
              type=click.Choice(["0", "1", "2", "3"]))
@click.option('--force-now', help="Simulate current time", callback=parse_time)
def clock_cli(degree, force_now):
    if force_now:
        click.echo(clock(int(degree), force_now=force_now))
    else:
        click.echo(clock(int(degree)))


if __name__ == '__main__':
    clock_cli()
