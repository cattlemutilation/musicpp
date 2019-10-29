with open("tempo", 'w') as f:
    for i in range(60, 121):
        h = 60.0/i
        h = (h/4.0)*100000000        
        f.write("X\"" + str(hex(int(h))) + "\" when tempo = \"" + str(bin(i)) + "\" else\n")

