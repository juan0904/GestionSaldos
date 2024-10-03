USE [GestionCobrosDB]
GO
/****** Object:  StoredProcedure [dbo].[SP_asignarSaldosAGestores]    Script Date: 02/10/2024 21:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_asignarSaldosAGestores]
AS
BEGIN
    -- Declaración de variables
    DECLARE @gestorId INT = 1;
	DECLARE @gestores INT = 10;
    DECLARE @saldo INT;
    DECLARE @index INT = 1;
    
    -- Se crea una tabla temporal para almacenar los gestores
    CREATE TABLE #GestoresTemp (GestorId INT, TotalSaldos INT);
    
    -- Inserta los gestores en la tabla temporal 
	  WHILE @gestorId <= @gestores
    BEGIN
        INSERT INTO #GestoresTemp (GestorId, TotalSaldos)
		VALUES (@gestorId, 0); -- Inicializamos TotalSaldos en 0
		SET @gestorId = @gestorId + 1;
    END
    
    -- Tabla con los saldos 
    DECLARE @Saldos TABLE (Saldo INT);
    INSERT INTO @Saldos (Saldo)
     VALUES (2277), (3953), (4726), (1414), (627), (1784), (1634), (3958), (2156), 
           (1347), (2166), (820), (2325), (3613), (2389), (4130), (2007), (3027), 
           (2591), (3940), (3888), (2975), (4470), (2291), (3393), (3588), (3286), 
           (2293), (4353), (3315), (4900), (794), (4424), (4505), (2643), (2217), 
           (4193), (2893), (4120), (3352), (2355), (3219), (3064), (4893), (272), 
           (1299), (4725), (1900), (4927), (4011);

    -- Cursor para recorrer los saldos
    DECLARE SaldoCursor CURSOR FOR
    SELECT Saldo FROM @Saldos ORDER BY Saldo DESC;

    OPEN SaldoCursor;
    FETCH NEXT FROM SaldoCursor INTO @saldo;

    -- Bucle para asignar saldos a los gestores
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Asigna el saldo al gestor
        UPDATE #GestoresTemp
        SET TotalSaldos = TotalSaldos + @saldo
        WHERE GestorId = @index;

        -- Incrementa el índice del gestor hasta 10 que es la cantidad de gestores
        SET @index = @index + 1;
        IF @index > @gestores
        BEGIN
            SET @index = 1;
        END

        FETCH NEXT FROM SaldoCursor INTO @saldo;
    END

    -- Cierra el cursor
    CLOSE SaldoCursor;
    DEALLOCATE SaldoCursor;

    -- Devuelve la tabla de saldos asignados
    SELECT * FROM #GestoresTemp;

    -- Limpia la tabla temporal
    DROP TABLE #GestoresTemp;
END