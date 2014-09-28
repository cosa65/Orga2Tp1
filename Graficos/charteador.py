import matplotlib.pyplot as plt; plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt


# Example data
numeros = ('uno', 'dos', 'tres', 'cuatro', 'cinco')

y_pos = np.arange(len(numeros))

tiempos = [1,5,1,5,1]

varianzas = [0.2,0.5,0.8,0.1,0.9]

colour = ['black','cornflowerblue','seashell','lemonchiffon','violet']

plt.barh(y_pos, tiempos, xerr=varianzas, align='center', alpha=0.4, color = colour)
plt.yticks(y_pos, numeros)
plt.xlabel('Aca te muestro hasta donde llegan los numeros')
plt.title('Numeros Aburridos')

plt.show()
