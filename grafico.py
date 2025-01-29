#bibliotecas
import numpy as np
import matplotlib.pyplot as plt

#carrega os dados gerado pelo nosso programa no fortran
dados = np.loadtxt('dados.txt', skiprows=1)

#criando uma matriz com colunas individuais
tempo = dados[:, 0] #tempo 
s = dados[:, 1] #sucetiveis
i = dados[:, 2] #infectados
r = dados[:, 3] #recuperada


plt.figure(figsize=(10, 6)) #tamanho do grafico

#curvas de evolução da população
plt.plot(tempo, s, label='Suscetíveis', color='blue')
plt.plot(tempo, i, label='Infectados', color='red')
plt.plot(tempo, r, label='Recuperados', color='green')


plt.title("Epidemia") #nome do grafico

#nome dos eixos
plt.xlabel("Tempo")
plt.ylabel('Fração da população')

plt.legend() #legenda para as curvas
plt.grid() #adiciona uma grade
plt.show() #para exibir o grafico