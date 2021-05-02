USE `ArtBase`;
/*PRIMERA BUSQUEDA*/
SELECT
	t1.nombreCliente, t1.gastoTotal,
	t4.nombreArtista ,t5.estilo
FROM
	cliente t1
	INNER JOIN RELACION_CLIENTE_GRUPO 	USING(ID_cliente)
	INNER JOIN RELACION_OBRA_GRUPO 		USING(ID_grupo)
	INNER JOIN obraDeArte 			USING(ID_obraDeArte)
	INNER JOIN artista t4 			USING(ID_artista)
	INNER JOIN estilo t5			USING(ID_estilo)
ORDER BY
	gastoTotal DESC;

SELECT '|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'; 
SELECT '|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||';

    /*SEGUNDA BÚSQUEDA*/
SELECT
	nombreArtista, SUM(precio)
FROM
	artista
 	INNER JOIN obraDeArte USING(ID_Artista)
GROUP BY
	nombreArtista
ORDER BY
	SUM(precio) ASC;
