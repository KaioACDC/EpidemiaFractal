import numpy as np
import matplotlib.pyplot as plt
import random

L = 100
rede = np.zeros((L, L), dtype=int) 

centro = L // 2 
rede[centro, centro] = 1