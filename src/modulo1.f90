!Criando modulo
module sistema 
    implicit none

contains
    !Subrotina que para o sistema de equações diferencias
    subroutine sistema_e_d(t, y, dydt, t_inf, t_rec)
        
        !parametros de entrada
        real(8), intent(in) :: t !tempo atual
        real(8), intent(in) :: t_inf !taxa de infecção
        real(8), intent(in) :: t_rec !taxa de recuperação
        real(8), intent(in) :: y(3) !vetor de estado

        !parametros de saida
        real(8), intent(out) :: dydt(3) !derivadas de estado

        !corrigindo possivel erro para tempo negativo
        if (t < 0.0) then
            print*, "Tempo negativo"
        end if
        
        !Definindo as equações diferencias do modelo
        dydt(1) = -t_inf * y(1) * y(2) !variação de sucetiveis
        dydt(2) = t_inf * y(1) * y(2) - t_rec * y(2) !variação de infectados
        dydt(3) = t_rec * y(2) !varição de recuperados

    end subroutine sistema_e_d

    !subrotina para metodo de Runge-Kutta de 4ª ordem
    subroutine kutta_sistema(delta_t, y0, t_inf, t_rec, pt, arquivo_saida)
        
        !parametros de entrada
        real(8), intent(in) :: delta_t(2) !intervalo de tempo
        real(8), intent(in) :: t_inf !taxa de infecçao
        real(8), intent(in) :: t_rec !taxa de recuperação
        real(8), intent(in) :: y0(3) !condições iniciais
        integer, intent(in) :: pt !número de pontos no tempo
        character(len=*), intent(in) :: arquivo_saida !arquivo de saida


        real(8) :: h, t, y(3) 
        real(8) :: k1(3), k2(3), k3(3), k4(3) !termos do metodo de Runge-Kutta
        integer :: i, unit !variaveis auxiliares

        !abrindo o arquivo para escrita
        open(newunit=unit, file=arquivo_saida, status='replace', action='write') 

        !calculo o tamanho do passo de tempo
        h = (delta_t(2) - delta_t(1)) / (pt - 1)

        !inicializa o tempo e estado com valores iniciais
        t = delta_t(1)
        y = y0

        !escreve os valores iniciais no arquivo
        write(unit, '(5F12.6)') t, y(1), y(2), y(3)

        do i = 2, pt
            !Calculando os coeficientes do metodo de Runge-Kutta de 4ª ordem
            call sistema_e_d(t, y, k1, t_inf, t_rec)
            call sistema_e_d(t + 0.5*h, y + 0.5*h*k1, k2, t_inf, t_rec)
            call sistema_e_d(t + 0.5*h, y + 0.5*h*k2, k3, t_inf, t_rec)
            call sistema_e_d(t + h, y + h*k3, k4, t_inf, t_rec)

            !atualizando o vetor de estado com a aproximação de Runge-Kutta
            y = y + (h/6.0)*(k1 + 2*k2 + 2*k3 + k4)
            t = t + h   
            
            !Escreve os valores no arquivo
            write(unit, '(5F12.6)') t, y(1), y(2), y(3)
        end do
    end subroutine
end module sistema