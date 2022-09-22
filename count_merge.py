#!/bin/python
import sys
import re

def main():
    dicts = {}
    for file in sys.argv[1:]:
        with open(file,"r") as f:
            for line in f:
                key,value = line.strip().split()
                if key not in dicts:
                    dicts[key] = value
                else:
                    dicts[key] = dicts[key] + "\t" + value
    return dicts

def writes():
    geninfo = Geneinfo()
    dicts = main()
    h = open("count_merge.txt","w")
    h.write("ID" + "\t" + "Gene" + "\t" + "Length" + "\t" + "\t".join(sys.argv[1:]) + "\n")
    for key,value in dicts.items():
        copykey = key
        if key in geninfo.keys():
            length = geninfo[key][1]
            key = geninfo[key][0]
        else:
            length = 0
            key = key
        #length = geninfo[copykey][1]
        h.write(copykey + "\t" + key + "\t" + str(length) + "\t" + value + "\n")
    h.close()

def Geneinfo():
    geninfo = {}
    with open("../../AL.filter.final.geneSymbol.gff3","r") as w:
        for line in w:
            content = line.strip().split()
            if content[2] != "gene":
                continue
            ID = re.search(r"ID=(.*?);",content[8])[1]
            if re.search(r"Gene_Symbol=(.*)",content[8]):
                if re.search(r"Gene_Symbol=(.*)",content[8])[1] != "Unknown":
                    gene = re.search(r"Gene_Symbol=(.*)",content[8])[1]
                else:
                    gene = ID
            else:
                gene = ID
            length = int(content[4]) - int(content[3])
            #print(ID + "\t" + gene)
            geninfo[ID] = [gene,length]
    return geninfo

if __name__ == "__main__":
    writes()
