      SUBROUTINE SETSHLD(TSC,THETA,D,SSG,DSR,USC)  
      REAL::VISC,GP,SSG,TMP,DSR,D,THETA,TSC,USC
C CHANGE RECORD  
C  
C  
C **  NONCOHEASIVE SEDIMENT SETTLING AND SHIELDS CRITERIA  
C **  USING VAN RIJN'S EQUATIONS  
C  
      VISC=1.E-6  
      GP=(SSG-1.)*9.82  
      TMP=GP/(VISC*VISC)  
      DSR=D*(TMP**0.333333)  
      GPD=GP*D  
C  
C **  SHIELDS  
C  
      IF(DSR.LE.4.0)THEN  
        THETA=0.24/DSR  
      ENDIF  
      IF(DSR.GT.4.0.AND.DSR.LE.10.0)THEN  
        THETA=0.14/(DSR**0.64)  
      ENDIF  
      IF(DSR.GT.10.0.AND.DSR.LE.20.0)THEN  
        THETA=0.04/(DSR**0.1)  
      ENDIF  
      IF(DSR.GT.20.0.AND.DSR.LE.150.0)THEN  
        THETA=0.013*(DSR**0.29)  
      ENDIF  
      IF(DSR.GT.150.0)THEN  
        THETA=0.055  
      ENDIF  
      TSC=GPD*THETA  
      USC=SQRT(TSC)  
      RETURN  
      END  

