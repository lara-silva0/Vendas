SELECT
    P.idProduto,
    P.nomeProduto,
    P.preco
FROM
    Produto P
JOIN
    ItemVenda IV ON P.idProduto = IV.idProduto
GROUP BY
    P.idProduto, P.nomeProduto, P.preco
HAVING
    COUNT(DISTINCT IV.idVenda) = (SELECT COUNT(DISTINCT idVenda) FROM Venda);
