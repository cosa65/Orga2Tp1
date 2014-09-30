import matplotlib.pyplot as plt; plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt


# Example data
nombres = ('O0','O1','O2','O3','asm')

y_pos = np.arange(len(nombres))

tiempos = [17694922,5513945,4889967,4698057,1577304]

desviosEstandar = [114064,24808,12316,68282,17601]

colour = ['black','darkgreen','darkseagreen','palegreen','firebrick','indianred','tan']



plt.barh(y_pos, tiempos, xerr=desviosEstandar, align='center', alpha=0.6, color = colour, picker = 1)
plt.yticks(y_pos, nombres)
plt.xlabel('Tiempos (ciclos)')

for i,j in zip(tiempos,y_pos):
    plt.annotate(str(tiempos[j]),xy=(i,j+0.2))

plt.title('Comparacion tiempos asm/C Motion Blur')

plt.show()
