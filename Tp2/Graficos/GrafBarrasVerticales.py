import matplotlib.pyplot as plt; plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt



#nombres=[]

#for i in range(10):
#	nombres.append(i)

nombres = [1,2,3,4,5,6,7,8,9,10]

y_pos = [0,1,2,3,4,5,6,7,8,9]

valores = [289209, 302654, 258757,254428, 248527, 254606,260391, 338981, 373612,280937]

colour = 'blue'

plt.bar(y_pos, valores, alpha=0.6, color = colour)
plt.xlabel('Numero de Medicion')
plt.xticks(y_pos, nombres)
plt.title('Cantidad de Ciclos por Medicion')

plt.show()
