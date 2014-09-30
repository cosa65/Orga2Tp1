import matplotlib.pyplot as plt; plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt


# Example data
nombres = ('original','programas','sin outliers')

y_pos = np.arange(len(nombres))

tiempos = [240254,286210,224103]

desviosEstandar = [5533,56191,10864]

colour = ['black','darkgreen','firebrick']

# xerr=desviosEstandar,

plt.barh(y_pos, tiempos, align='center', alpha=0.6, color = colour, picker = 1)
plt.yticks(y_pos, nombres)
plt.xlabel('Tiempos (ciclos)')

for i,j in zip(tiempos,y_pos):
    plt.annotate(str(tiempos[j]),xy=(i,j+0.2))

plt.title('Esperanzas - Cropflip (10 corridas)')

plt.show()
