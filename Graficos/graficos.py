import numpy as np
import matplotlib.pyplot as plt

x = [0 for i in range(10)]
y = [0 for j in range(10)]

for i in range(10):
	x[i]=i

for j in range(10):
	y[j]=j+3

plt.plot(x, y, label = "lineal")

#plt.plot(x, x**2, label = "cuadratico" )



plt.legend()

plt.show()
