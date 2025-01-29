module sistema 
    implicit none

contains
    subroutine sistema_e_d(t, y, dydt, t_inf, t_rec)

        real(8), intent(in) :: t
        real(8), intent(in) :: t_inf
        real(8), intent(in) :: t_rec
        real(8), intent(in) :: y(4)

        
        real(8), intent(out) :: dydt(4)