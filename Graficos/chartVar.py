import matplotlib.pyplot as plt; plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt


# Example data
nombres = ('original','16 mem','16 cuentas')

y_pos = np.arange(len(nombres))

tiempos = [1621513,2109353,1851460]

desviosEstandar = [5533,56191,10864]

colour = ['black','darkgreen','firebrick']

# xerr=desviosEstandar,

plt.barh(y_pos, tiempos, align='center', alpha=0.6, color = colour, picker = 1)
plt.yticks(y_pos, nombres)
plt.xlabel('Tiempos (ciclos)')

for i,j in zip(tiempos,y_pos):
    plt.annotate(str(tiempos[j]),xy=(i,j+0.2))

plt.title('bus vs cpu - Sierpinski')

plt.show()
