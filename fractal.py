#bibliotecas
import numpy as np
import matplotlib.pyplot as plt
import random

L = 100 #tamanho da rede quadrada
rede = np.zeros((L, L), dtype=int) #zerando a rede

centro = L // 2 #definindo o centro da rede 
rede[centro, centro] = 1 #marcando o centro como infectado

epidemia = [] #lista para armazenar os locais infectados

#adiciona os vizinhos imediatos do centro à lista
for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
    x, y = centro + dx, centro + dy
    if 0 <= x < L and 0 <= y < L: #garante que os vizinhos estão dentro do limite
        epidemia.append((x, y))

plt.ion() #ativa modo interativo
fig, ax = plt.subplots() 
im = ax.imshow(rede, cmap='viridis', vmin=0, vmax=1) #cria vizualização unica
plt.colorbar(im) #adiciona barra de cor
ax.set_title("Crescimento pandêmico fractal") #titulo do grafico

#função para atualizar o grafico em tempo real
def atualizar_plot():
    im.set_data(rede) #atualiza a imagem com o estado atual da red
    fig.canvas.flush_events() #atualiza o canva do matplotlib

max_iter = 5000 #numero de iterações

#loop para o crescimento pandemico
for i in range(max_iter):
    if not epidemia: #se nao tive mais locais acaba o loop
        break

    # Escolhe um sítio de crescimento aleatoriamente
    idx = random.randint(0, len(epidemia) - 1)
    x, y = epidemia.pop(idx) #remove o local de lista e atribui o x e y

    #Marca o local com infectado
    rede[x, y] = 1

    # Adiciona os vizinhos desocupados à lista de crescimento
    for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
        nx, ny = x + dx, y + dy
        if 0 <= nx < L and 0 <= ny < L and rede[nx, ny] == 0 and (nx, ny) not in epidemia:
            epidemia.append((nx, ny))

    # Atualiza o grafico a cada 10 interações
    if i % 10 == 0:
        atualizar_plot()

plt.ioff() #desativa o modo interativo
plt.show() #exibe o grafico