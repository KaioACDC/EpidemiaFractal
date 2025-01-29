program main
  use sistema !importando o modulo1.f90
    implicit none

    !parametros
    real(8) :: delta_t(2) = [0.0, 150.0] !intervalo de tempo
    real(8) :: y0(3) = [0.7, 0.01, 0.0] !condiçoes iniciais do sistema (s, i, r)
    real(8) :: t_inf = 0.5 !taxa de infecção
    real(8) :: t_rec = 0.1 !taxa de recuperação
    integer :: pt = 1000 !números de pontos na simulação
    character(len=*), parameter :: arquivo_saida = 'dados.txt' !arquivo de saida

    !resolvendo o sistema com Runge-Kutta
    call kutta_sistema(delta_t, y0, t_inf, t_rec, pt, arquivo_saida) !
    
    !Indicando que os dados foram salvos
    print*, "Dados salvos em", arquivo_saida
end program main