import io, re


DIALOG_DECLARATION_LINE_REGEX = re.compile(r'\s*\((?P<id>.*?),\s*(?P<edge>Side\w+)\s*,\s*Point\(\s*(?P<x1>[-_a-zA-Z0-9]+),\s*(?P<y1>[-_a-zA-Z0-9]+)\s*\)\s*,\s*Point\(\s*(?P<x2>[-_a-zA-Z0-9]+),\s*(?P<y2>[-_a-zA-Z0-9]+)\s*\)\s*,\s*(?P<trans>\d*(?:\.\d+)?)\s*,\s*(?P<flags>(?:0x)?\w+)\s*,\s*(?P<undetectable>true|false)\s*\)\s*')


FLAGS = {
    0b00000000000000001: 'ofInHangar',
    0b00000000000000010: 'ofInFlightCommand',
    0b00000000000000100: 'ofInStationCommand',
    0b00000000000001000: 'ofInFlight',
    0b00000000000010000: 'ofInCockpit',
    0b00000000000100000: 'ofInChase',
    0b00000000001000000: 'ofInLoadout',
    # 00000000010000000 is indeed unused, see enum OverlayFlag in console.h! (https://github.com/AllegianceZone/Allegiance/blob/HEAD/src/WinTrek/console.h#L39)
    0b00000000100000000: 'ofTeleportPane',
    0b00000001000000000: 'ofInvestment',
    0b00000010000000000: 'ofGameState',
    0b00000100000000000: 'ofTeam',
    0b00001000000000000: 'ofExpandedTeam',
    0b00010000000000000: 'ofInventory',
    0b00100000000000000: 'ofCommandPane',
    0b01000000000000000: 'ofSectorPane',
    0b10000000000000000: 'ofGloatCam',
}

print(sorted(FLAGS.items()))


def split_flags(flags):
    intflags = int(flags) if not flags.startswith('0x') else int(flags, 16)

    consts = []
    for val, const in sorted(FLAGS.items(), reverse=True):
        if intflags & val:
            consts.append(const)
            intflags -= val

    return ' | '.join(reversed(consts))


with io.open('../Code/dialog.mdl') as f:
    lines = f.readlines()

    dialogs_has_begun = False
    for line in lines:
        if 'dialogs =' in line:
            dialogs_has_begun = True

        if dialogs_has_begun:
            m = DIALOG_DECLARATION_LINE_REGEX.match(line)
            if m:

                d = m.groupdict()
                #print(d)
                d['new_flags'] = split_flags(d['flags'])

                print('        ({id}, {edge}, Point({x1}, {y1}), Point({x2}, {y2}), {trans}, {new_flags}, {undetectable}),'.format(**d))
            else:
                print(line[:-1])
