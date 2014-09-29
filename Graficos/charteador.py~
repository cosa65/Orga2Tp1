import matplotlib.pyplot as plt; plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt


# Example data
nombres = ('O0','O1','O2','O3','asm')

y_pos = np.arange(len(nombres))

tiempos = [613445,156148,106859,106740,46671]

desviosEstandar = [3278,1178,1354,1235,764]

colour = ['darkblue','mediumslateblue','lightskyblue','powderblue','green']



plt.barh(y_pos, tiempos, xerr=desviosEstandar, align='center', alpha=0.4, color = colour, picker = 1)
plt.yticks(y_pos, nombres)
plt.xlabel('Tiempos (ciclos)')

for i,j in zip(tiempos,y_pos):
    plt.annotate(str(tiempos[j]),xy=(i,j+0.2))

plt.title('Comparacion tiempos de implementacion en C/asm (Cropflip)')

plt.show()
