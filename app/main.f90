program main
  use sistema
    implicit none

    real(8) :: delta_t(2) = [0.0, 50.0]
    real(8) :: y0(4) = [0.7, 0.01, 0.0, 0.29]
    real(8) :: t_inf = 0.5
    real(8) :: t_rec = 0.1
    integer :: pt = 1000
    character(len=*), parameter :: arquivo_saida = 'dados.txt'
