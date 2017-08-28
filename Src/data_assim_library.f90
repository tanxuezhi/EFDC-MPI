

! BUILDS H MATRIX
SUBROUTINE HMATRIX2(NL,NR,VP_I,VP_J,VP_K,MODEL_I,MODEL_J,MODEL_K,H)
    IMPLICIT NONE
    INTEGER,PARAMETER::IP=4,WP=8
    INTEGER(IP),INTENT(IN)::NL,NR
    INTEGER(IP),DIMENSION(NL),INTENT(in)::MODEL_I,MODEL_J,MODEL_K
    INTEGER(IP),DIMENSION(NR),INTENT(in)::VP_I,VP_J,VP_K
    INTEGER(IP),ALLOCATABLE,DIMENSION(:,:)::C
    INTEGER(IP),DIMENSION(NR,NL)::H

    INTEGER(IP)I,J
    ALLOCATE(C(NR,NL))
    H = 0
    DO I=1,NR
        DO J=1,NL
            IF (VP_I(I)==MODEL_I(j) .AND. VP_J(I)==MODEL_J(J) .AND. VP_K(I)==MODEL_K(J)) then
                H(I,J) = 1
            ELSE
                H(I,J) = 0
            END IF
        END DO
    END DO

    !OPEN(3,file='testh.dat',status='unknown')
    !DO I=1,NR
    !  WRITE(3,1) (H(I,J),J=1,NL)
    !END DO
    !CLOSE(3)
1   FORMAT(16000I1)

END SUBROUTINE HMATRIX2

! BUILDS THE STATE ERROR COVARIANCE MATRIX P
SUBROUTINE PMATRIX2(NL,MODEL_I,MODEL_J,MODEL_K,P, &
                    PMATRIX_R1, PMATRIX_R2, PMATRIX_R3, PMATRIX_A )
    IMPLICIT NONE
    INTEGER,PARAMETER::IP=4,WP=8
    INTEGER(IP) N,I,J
    REAL(WP) R1,R2,R3,A
    INTEGER(IP),INTENT(IN)::NL
    INTEGER(IP),DIMENSION(NL),INTENT(IN)::MODEL_I,MODEL_J,MODEL_K
    REAL(WP),DIMENSION(NL,NL)::P
    REAL(WP),ALLOCATABLE,DIMENSION(:,:)::P1
    REAL PMATRIX_R1, PMATRIX_R2, PMATRIX_R3, PMATRIX_A 
 
    R1 = PMATRIX_R1
    R2 = PMATRIX_R2
    R3 = PMATRIX_R3
    A  = PMATRIX_A
    N=0

    DO I=1,NL
        N=N+1
        DO J=1,NL
            P(I,J) = A*EXP(-1.*(((MODEL_I(I) - MODEL_I(I+J-N))/R1)**2 + &
                ((MODEL_J(I) - MODEL_J(I+J-N))/R2)**2 + &
                ((MODEL_K(I) - MODEL_K(I+J-N))/R3)**2))
        END DO
    END DO
!OPEN(3,FILE='testp.dat',STATUS='UNKNOWN')
!DO I=1,NL
!  WRITE(3,*) (P(I,J),J=1,NL)
!END DO
!CLOSE(3)

END SUBROUTINE PMATRIX2

! BUILDS THE OBSERVATION ERROR COVARIANCE MATRIX R
SUBROUTINE RMATRIX2(NR,SIGMAT,R)
    IMPLICIT NONE
    INTEGER,PARAMETER::IP=4,WP=8
    INTEGER(IP) NR,I,J
    REAL(WP),DIMENSION(NR),INTENT(IN)::SIGMAT
    REAL(WP),DIMENSION(NR,NR)::R

    R=0.
    DO I=1,NR
        R(I,I) = SIGMAT(I)
    END DO

!OPEN(3,FILE='testr.dat',STATUS='UNKNOWN')

!DO I=1,NR
!  WRITE(3,*) (R(I,J),J=1,NR)
!END DO
!CLOSE(3)

END SUBROUTINE RMATRIX2