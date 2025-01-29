module sistema 
    implicit none

contains
    subroutine sistema_e_d(t, y, dydt, t_inf, t_rec)

        real(8), intent(in) :: t
        real(8), intent(in) :: t_inf
        real(8), intent(in) :: t_rec
        real(8), intent(in) :: y(4)

        
        real(8), intent(out) :: dydt(4)

        if (t < 0.0) then
            print*, "Tempo negativo"
        end if
        
        dydt(1) = -t_inf * y(1) * y(2)
        dydt(2) = t_inf * y(1) * y(2) - t_rec * y(2)
        dydt(3) = t_rec * y(2)
        dydt(4) = 0 

    end subroutine sistema_e_d

    subroutine kutta_sistema(delta_t, y0, t_inf, t_rec, pt, arquivo_saida)

        real(8), intent(in) :: delta_t(2)
        real(8), intent(in) :: t_inf
        real(8), intent(in) :: t_rec
        real(8), intent(in) :: y0(4)
        integer, intent(in) :: pt
        character(len=*), intent(in) :: arquivo_saida

        real(8) :: h, t, y(4)
        real(8) :: k1(4), k2(4), k3(4), k4(4)
        integer :: i, unit

        open(newunit=unit, file=arquivo_saida, status='replace', action='write')

        h = (delta_t(2) - delta_t(1)) / (pt - 1)

        t = delta_t(1)
        y = y0

        write(unit, "(A)")

        write(unit, '(5F12.6)') t, y(1), y(2), y(3), y(4)

        do i = 2, pt
            !Método de Runge-Kutta de 4 ordem
            call sistema_e_d(t, y, k1, t_inf, t_rec)
            call sistema_e_d(t + 0.5*h, y + 0.5*h*k1, k2, t_inf, t_rec)
            call sistema_e_d(t + 0.5*h, y + 0.5*h*k2, k3, t_inf, t_rec)
            call sistema_e_d(t + h, y + h*k3, k4, t_inf, t_rec)

            y = y + (h/6.0)*(k1 + 2*k2 + 2*k3 + k4)
            t = t + h
            
            write(unit, '(5F12.6)') t, y(1), y(2), y(3), y(4)
        end do
    end subroutine
end module sistema