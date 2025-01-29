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

max_iter = 5000

for i in range(max_iter):
    if not epidemia:
        break

    # Escolhe um sítio de crescimento aleatoriamente
    idx = random.randint(0, len(epidemia) - 1)
    x, y = epidemia.pop(idx)

    # Ocupa o sítio
    rede[x, y] = 1

    # Adiciona os vizinhos desocupados à lista de crescimento
    for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
        nx, ny = x + dx, y + dy
        if 0 <= nx < L and 0 <= ny < L and rede[nx, ny] == 0 and (nx, ny) not in epidemia:
            epidemia.append((nx, ny))

    # Atualiza o plot em tempo real
    if i % 10 == 0:
        atualizar_plot()

plt.ioff()
plt.show()