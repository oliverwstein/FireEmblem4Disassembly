#!/usr/bin/env python3
"""Auto-generate 1-to-1 offset tables in data/offset/*.csv.asm from their source files."""
import csv
import datetime
import os
import re

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def read_csv_names(rel_path, multi_name_cols=1):
    path = os.path.join(ROOT, rel_path)
    with open(path, encoding='utf-8') as f:
        rows = list(csv.reader(f))[1:]
    names = []
    for row in rows:
        name = next((c.strip() for c in row[:multi_name_cols] if c.strip()), '')
        if name:
            names.append(name)
    return names


def read_menutext_labels(rel_path):
    path = os.path.join(ROOT, rel_path)
    text = open(path, encoding='utf-8').read()
    return re.findall(r'^\s*([A-Za-z0-9_]+)\s+\.text\b', text, re.M)


def read_sprite_assignment_labels(rel_path):
    path = os.path.join(ROOT, rel_path)
    text = open(path, encoding='utf-8').read()
    return re.findall(r'^\s*(a([A-Za-z0-9_]+)MapSpriteAssignment)\b', text, re.M)


def write_offset_asm(out_rel, source_desc, entries, start=0):
    """Write a 64tass offset table matching tools/c2a.py's symbol conventions."""
    tablename = os.path.basename(out_rel).removesuffix('.csv.asm')  # e.g. ClassDataOffsets
    namewidth = max(len(name) for name, _ in entries)
    reserved = 2 + namewidth + len('Offset')

    lines = [f'; Made by tools/gen_offsets.py from {source_desc} on {datetime.date.today().isoformat()}; do not edit.\n']
    table = []
    for idx, (name, expr) in enumerate(entries):
        lines.append(f'{name.ljust(reserved)} = {start + idx}\n')
        lines.append(f'{("  " + name + "Offset").ljust(reserved)} = {expr}\n\n')
        table.append(f'{name}{tablename}Entry .word {name}Offset\n')

    out_path = os.path.join(ROOT, out_rel)
    with open(out_path, 'w', encoding='utf-8') as f:
        f.writelines(lines)
        f.writelines(table)


def main():
    # 1. CSV-backed 1-to-1 data tables
    write_offset_asm(
        'data/offset/CharacterDataOffsets.csv.asm',
        'data/character/CharacterData.csv',
        [(n, f'aCharacterData.{n}CharacterDataEntry - aCharacterDataOffsets')
         for n in read_csv_names('data/character/CharacterData.csv', multi_name_cols=3)],
        start=1,
    )

    for out_rel, src_rel, name_cols, data_sym, entry_suffix, off_sym, prefix, suffix in [
        ('data/offset/ClassDataOffsets.csv.asm', 'data/class/ClassData.csv', 1, 'aClassData', 'ClassDataEntry', 'aClassDataOffsets', '', ''),
        ('data/offset/ItemDataOffsets.csv.asm', 'data/item/ItemData.csv', 2, 'aItemData', 'ItemDataEntry', 'aItemDataOffsets', '', ''),
        ('data/offset/ChildrenDataOffsets.csv.asm', 'data/character/ChildrenData.csv', 1, 'aChildrenData', 'ChildrenDataEntry', 'aChildrenDataOffsets', '', ''),
        ('data/offset/HolyBloodDataOffsets.csv.asm', 'data/item/HolyBloodData.csv', 1, 'aHolyBloodData', 'HolyBloodDataEntry', 'aHolyBloodGrowthBoostsOffsets', '', ''),
        ('data/offset/MovementCostOffsets.csv.asm', 'data/terrain/MovementCost.csv', 1, 'aMovementCost', 'MovementCostEntry', 'aMovementCostOffsets', '', 'Movement'),
        ('data/offset/TerrainAvoidOffsets.csv.asm', 'data/terrain/TerrainAvoid.csv', 1, 'aTerrainAvoid', 'TerrainAvoidEntry', 'aTerrainAvoidOffsets', 'TerrainAvoid', ''),
    ]:
        entries = []
        for n in read_csv_names(src_rel, multi_name_cols=name_cols):
            sym_name = n
            if src_rel == 'data/item/HolyBloodData.csv':
                sym_name = n.removesuffix('Blood')
            else:
                sym_name = prefix + n + suffix
            entries.append((sym_name, f'{data_sym}.{n}{entry_suffix} - {off_sym}'))
        write_offset_asm(out_rel, src_rel, entries, start=0)

    # 2. Gen1 + Gen2 love tables
    for kind, suffix, gen1_csv, gen2_csv, gen1_sym, gen2_sym, off_sym in [
        ('LoveBase', 'LoveBase', 'data/character/Gen1LoveBases.csv', 'data/character/Gen2LoveBases.csv',
         'aGen1LoveBases', 'aGen2LoveBases', 'aLoveBaseOffsets'),
        ('LoveGrowth', 'LoveGrowth', 'data/character/Gen1LoveGrowths.csv', 'data/character/Gen2LoveGrowths.csv',
         'aGen1LoveGrowths', 'aGen2LoveGrowths', 'aLoveGrowthOffsets'),
    ]:
        g1 = [(f'{n}{suffix}', f'{gen1_sym}.{n}Gen1{kind}sEntry - {off_sym}') for n in read_csv_names(gen1_csv)]
        g2 = [(f'{n}{suffix}', f'{gen2_sym}.{n}Gen2{kind}sEntry - size(structGen1LoveEntry) - {off_sym}') for n in read_csv_names(gen2_csv)]
        write_offset_asm(f'data/offset/{kind}Offsets.csv.asm', f'{gen1_csv} + {gen2_csv}', g1 + g2, start=0)

    # 3. ClassMapSpriteAssignmentOffsets
    sprite_labels = read_sprite_assignment_labels('data/class/ClassMapSpriteAssignment.asm')
    write_offset_asm(
        'data/offset/ClassMapSpriteAssignmentOffsets.csv.asm',
        'data/class/ClassMapSpriteAssignment.asm',
        [(cls_name, f'{full_label} - aClassMapSpriteAssignmentOffsets') for full_label, cls_name in sprite_labels],
        start=0,
    )

    # 4. 1-to-1 menutext tables
    for out_rel, txt_rel, data_sym, off_sym, sym_suffix in [
        ('data/offset/CastleNameOffsets.csv.asm', 'text/menutext/CastleNames.asm', 'aCastleNames', 'aCastleNameOffsets', 'Name'),
        ('data/offset/FactionNameOffsets.csv.asm', 'text/menutext/FactionNames.asm', 'aFactionNames', 'aFactionNameOffsets', ''),
        ('data/offset/TerrainNameOffsets.csv.asm', 'text/menutext/TerrainNames.asm', 'aTerrainNames', 'aTerrainNameOffsets', 'Name'),
    ]:
        labels = read_menutext_labels(txt_rel)
        write_offset_asm(
            out_rel,
            txt_rel,
            [(f'{lbl}{sym_suffix}', f'{data_sym}.{lbl} - {off_sym}') for lbl in labels],
            start=0,
        )


if __name__ == '__main__':
    main()
