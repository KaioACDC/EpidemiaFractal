import numpy as np
import matplotlib.pyplot as plt

dados = np.loadtxt('dados.txt', skiprows=1)

tempo = dados[:, 0]
s = dados[:, 1]
i = dados[:, 2]
r = dados[:, 3]
n = dados[:, 4]