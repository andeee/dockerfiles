#!/usr/bin/env sh
fhem_cfg="${1:-fhem.cfg}"
perl fhem.pl "${fhem_cfg}"