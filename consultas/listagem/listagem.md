Resultado esperado: Uma tabela listando os nomes de laboratórios, equipamentos associados e os clientes que utilizam os equipamentos.

Plano de execução:

O INNER JOIN relaciona as tabelas Laboratorio e Equipamento com base na chave estrangeira ID_Laboratorio.
A tabela Sofre conecta Equipamento às checagens realizadas, garantindo que só os equipamentos com checagens sejam incluídos.
A tabela Cliente é associada às checagens, listando os clientes que utilizaram os equipamentos.