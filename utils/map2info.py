#!/usr/bin/env python

import sys

START_ADDR_SEG = 2

# converts ld65 map file to da65 info file

if len(sys.argv) < 2:
    print("USAGE: map2info.py <map file> [vice label file [debug info]]")
    sys.exit(1)

items = open(sys.argv[1], "r").readlines()

def read_chunk(items):
    chunk = []
    while len(items) > 0:
        it = items[0].strip()
        items = items[1:]
        if it == '': break
        chunk.append(it)

    return chunk, items

segments = []
labels = []

while len(items) > 0:
    it = items[0].strip()
    items = items[1:]

    if it == 'Segment list:':
        segments, items = read_chunk(items[3:])

    if it == 'Exports list by value:':
        labels, items = read_chunk(items[1:])

segments = [tuple(it.split()) for it in segments]

labels = ' '.join(labels).split()
labels = [tuple(labels[i:i+3]) for i in range(0, len(labels), 3)]

label_map = {}
# load segments from map file into label map
for (name, start, end, size, align) in segments:
    label_map[start] = 'SEG_%s' % name

# store start address as label
label_map[segments[START_ADDR_SEG][1]] = '__START_ADDR__'

# append aditional segments for better dissasembly
segments.append(('VIDEO_RAM',      '006000', '007FFF', 0, 0))
segments.append(('HARDWARE_IO',    '008000', '009FFF', 0, 0))
segments.append(('EXTENSION_AREA', '00A000', '00AFFF', 0, 0))
segments.append(('DOS_ROM',        '00B000', '00BFFF', 0, 0))
segments.append(('BASIC_ROM',      '00C000', '00DFFF', 0, 0))
segments.append(('CHARGEN_ROM',    '00E000', '00E2FF', 0, 0))
segments.append(('SYSTEM_ROM',     '00E300', '00FFE7', 0, 0))
segments.append(('SYSTEM_ROM_VEC', '00FFE8', '00FFFF', 0, 0))


# load labels from map file
for (name, addr, type) in labels:
    if type[1] == 'E':
        continue
    label_map[addr] = name

# load labels from VICE label file
if len(sys.argv) > 2:
    items = open(sys.argv[2], "r").readlines()
    items.sort()

    for ln in items:
        l = ln.strip().split(' ')
        if l[0] == 'al':
            label_map[l[1]] = l[2][1:]

# load sizes of variables
def load_addr_sizes(file_name):
    def parse_dbg_line(o):
        map = {}
        for m in o.split(','):
            k, v = m.split('=')

            if k == 'name' and v[0] == '"':
                v = v[1:-1]

            map[k] = v
        return map

    items = open(file_name, "r").readlines()
    items = [tuple(it.split()) for it in items]

    segs = []
    spans = []

    for it, info in items:
        if it == 'seg':
            segs.append(info)
        if it == 'span':
            spans.append(info)

    seg_id_map = {}
    for s in segs:
        v = parse_dbg_line(s)
        seg_id_map[v['id']] = v

    addr_sizes = {}

    for s in spans:
        v = parse_dbg_line(s)
        sg = seg_id_map[v['seg']]
        if sg['name'] not in ['BSS', 'ZEROPAGE', 'DATA']:
            continue

        addr = "%06X" % (int(sg['start'], 16) + int(v['start']))
        
        if addr not in addr_sizes:
            addr_sizes[addr] = int(v['size'])

    return addr_sizes

addr_sizes = {}

if len(sys.argv) > 3:
    addr_sizes = load_addr_sizes(sys.argv[3])

# output
seg_map = {
    'ZEROPAGE': 'ByteTable',
    'LOADADDR': 'WordTable',
    'EXEHDR': 'Code',
    'CODE': 'Code',
    'RODATA': 'TextTable',
    'DATA': 'ByteTable',
    'GFX_DATA': 'ByteTable',
    'BSS': 'ByteTable',
}

print("# Generated by %s" % sys.argv[0])

print('# Global section')
print('GLOBAL {')
print('    STARTADDR  $%s;' % segments[START_ADDR_SEG][1])
print('    CPU        "6502";')
print('    INPUTOFFS  2;')
print('    COMMENTS   3;')
print('};')

def find_segname(addr):
    for (name, start, end, size, align) in segments:
        if addr >= start and addr <= end:
            return name
    return None


def mk_ranges(segments):
    rez = []
    for (name, start, end, size, align) in segments:
        if name in seg_map:
            type = seg_map[name]
        else:
            type = 'Code'
        rez.append('RANGE { START $%s; END $%s; TYPE %s; COMMENT "%s"; };' % (start, end, type, name))
    return rez

def mk_labels(label_map):
    rez = []
    for addr, name in label_map.iteritems():
        # ignore size labels generated by linker
        if name.startswith('__') and name.endswith('SIZE__'):
            continue

        li = [
            'ADDR $%s;' % addr,
            'NAME "%s";' % name,
        ]

        sn = find_segname(addr)
        if sn is not None:
            li.append('COMMENT "%s";' % sn)

        if addr in addr_sizes:
            li.append('SIZE %d;' % addr_sizes[addr])

        rez.append('LABEL { %s };' % ' '.join(li))

    rez.sort()
    return rez

print('# Ranges\n%s\n' % '\n'.join(mk_ranges(segments)))
print('# Labels\n%s\n' % '\n'.join(mk_labels(label_map)))
