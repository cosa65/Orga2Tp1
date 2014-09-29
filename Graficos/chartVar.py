import matplotlib.pyplot as plt; plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt


# Example data
nombres = ('O0','O1','O2','O3','asm')

y_pos = np.arange(len(nombres))

tiempos = [17694922,5513945,4889967,4698057,2030949]

desviosEstandar = [114064,24808,12316,68282,13739]

colour = ['darkblue','mediumslateblue','lightskyblue','powderblue','green']



plt.barh(y_pos, tiempos, xerr=desviosEstandar, align='center', alpha=0.4, color = colour, picker = 1)
plt.yticks(y_pos, nombres)
plt.xlabel('Tiempos (ciclos)')

for i,j in zip(tiempos,y_pos):
    plt.annotate(str(tiempos[j]),xy=(i,j+0.2))

plt.title('Comparacion tiempos de implementacion en C/asm (Motion Blur)')

plt.show()
