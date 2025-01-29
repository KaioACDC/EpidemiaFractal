import numpy as np
import matplotlib.pyplot as plt
import random

L = 100
rede = np.zeros((L, L), dtype=int) 

centro = L // 2 
rede[centro, centro] = 1

epidemia = []

for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
    x, y = centro + dx, centro + dy
    if 0 <= x < L and 0 <= y < L: 
        epidemia.append((x, y))

plt.ion()
fig, ax = plt.subplot()
im = ax.imshow(rede, cmap='viridis', vmin=0, vmax=1)
plt.colorbar(im)
ax.set_title("Crescimento pandêmico fractal")

def atualizar_plot():
    im.set_data(rede)
    fig.canvas.flush_events()

