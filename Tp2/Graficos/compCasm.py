import matplotlib.pyplot as plt; plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt



#nombres=[]

#for i in range(10):
#	nombres.append(i)

nombres = ['asm','O3','O2','O1','O0']

y_pos = [0.5,1.5,2.5,3.5,4.5]

valores = [46662, 107232, 107460,156480, 612549]

colour = ['green','black','darkslategray','gray','slategray']

desviosEstandar = [702,1235,1354,1178,3278]



plt.bar(y_pos, valores,yerr=desviosEstandar, alpha=1, color = colour)
plt.ylabel('Tiempos(ciclos)')
plt.xlabel('Implementacion')
plt.xticks(y_pos, nombres)
plt.title('Comparacion tiempos de implementacion en C/asm (Cropflip)')

plt.show()
