x = 0
with open("music", 'w') as f:
    for x in range(0, 2048):
        f.write("var_ram(" + str(x) + ") := \"00000000\";\n")
