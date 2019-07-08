#!/usr/bin/python
# -*- Coding: utf-8 -*-

"""
PyYAML package is required: pip install pyyaml
"""
from yaml import load, parse
try:
    from yaml import CLoader as Loader
except ImportError:
    from yaml import Loader

def parse_yml(elems,level=0,id=[]): #recursive search
    mylist = []
    index = 0
    for elem in elems:
        for key in elem.keys():
            tmp = elem[key]
            if type(tmp) == str:
                tmpdict = {}
                tmpdict["FILENAME"] = tmp
                tmpdict["LEVEL"] = level
                tmpdict["ID"] = id+[index]
                mylist.append(tmpdict)
            elif type(tmp) == list:
                tmplevel = level+1
                mylist += parse_yml(tmp,tmplevel,id+[index])
        index += 1
    return mylist

def numbering(filename,curr_index):
    with open(filename, "r") as file:
        dat = file.readlines() # original markdown
        dat2 = []              # numbered markdown
        is_pgline = False      # skip program lines
        for line in dat:
            tmpline = line.replace(" ","")
            if not is_pgline:
                #replace header line
                if tmpline[0] == '#':
                    # get header level
                    level = 0
                    for c in tmpline:
                        if c == '#':
                            level += 1
                        else:
                            break
                    # count up number
                    if level > 1:
                        curr_index[level-1] += 1
                    curr_index = curr_index[0:level]+[0]*(10-level-1) #[chapter,section,subsection,...]
                    index_str = '%d'%curr_index[0]
                    for idx in curr_index[1:level]:
                        index_str += '.%d'%idx
                    # replace header line
                    dat2.append(line.replace("#"*level,"#"*level+" "+index_str))
                    #print line.replace("#"*level,"#"*level+" "+index_str)
                    continue

            dat2.append(line)

            # skip program lines
            if is_pgline:
                if tmpline[0:3] == "```":
                    is_pgline = False
            else:
                if tmpline[0:3] == "```":
                    is_pgline = True

    with open(filename, "w") as file:
        file.writelines(dat2)
    return dat2

def main():
    with open('mkdocs.yml', "r") as file:
        yml = load(file, Loader=Loader)
        curr_index=[0]*10

        dat_all = []
        for item in parse_yml(yml['nav'],level=0):
            if item["ID"][0] > curr_index[0]:
                curr_index = curr_index[0:1]+[0]*9
            curr_index[0] = item["ID"][0]
            if curr_index[0] > 0:
                tmpdat = numbering('docs/'+item["FILENAME"], curr_index)
                dat_all.extend(tmpdat)

    with open("manual_all.md", "w") as file:
        file.writelines(dat_all)

if __name__ == "__main__":
    main()
