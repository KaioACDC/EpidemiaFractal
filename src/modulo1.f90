module sistema 
    implicit none

contains
    subroutine sistema_e_d(t, y, dydt, t_inf, t_rec)

        real(8), intent(in) :: t
        real(8), intent(in) :: t_inf
        real(8), intent(in) :: t_rec
        real(8), intent(in) :: y(4)

        
        real(8), intent(out) :: dydt(4)

        if t( < 0.0) then
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