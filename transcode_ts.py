# This is a sample Python script.

# Press Ctrl+Alt+R to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

import glob
import subprocess
TV_BASEDIR="d:/temp/dvrshows"
PROCESS_BAT="plex-process.bat"

PRESET_720="Fast 720p30"
PRESET_1080="Fast 1080p30"
DEFAULT_PRESET=PRESET_720
PRESET_MAP = {
    "NFL":  PRESET_1080,
}

def get_preset(file):
    for part, preset in PRESET_MAP.items():
        if part in file:
            return preset
    return DEFAULT_PRESET

def get_tvshow_ts_files(basedir):
    pattern = "{}/**/*.ts".format(basedir)
    return glob.glob(pattern, recursive=True)

def process_file(file):
    preset = get_preset(file)
    print("=== {} - preset: {} ===".format(file, preset))
    cmds = [PROCESS_BAT, file, preset]
    print(" - {}".format(cmds))
    result = subprocess.run(cmds, check=True)
    print(result)

def main(basedir):
    files = get_tvshow_ts_files(basedir)
    for file in files:
        process_file(file)


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    main(TV_BASEDIR)
