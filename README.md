# Alterações Realizadas

1. Removidas as tabelas Possui e Detém, e as relações foram integradas às tabelas diretamente através de chaves estrangeiras.

2. Criada a tabela Sofre para modelar o relacionamento n
entre Equipamento e Checagens.

3. Dividida a tabela Checagens em suas especializações Calibração e Manutenção, com herança da chave primária ID_Checagem.

4. Adicionadas as chaves estrangeiras correspondentes em Equipamento:

```
ID_Laboratorio (relacionamento 1
com Laboratório).
ID_Fornecedor (relacionamento 1
com Fornecedor).

```

---------------------------------------------------

# Modelo ER

## Escrita da sora

```
Modelo ER: - os dados a serem modelados devem guardar informações pertinentes a calibração e manutenção de equipamentos de laboratórios (e não serviços de manutenção e de calibração oferecidos pelos laboratórios). Então não faz sentido ter uma entidade "Cliente" nem "Contrato" - a notação solicitada para expressar cada cardinalidade era (mínimo,máximo), e não apenas o máximo. - nas especializações de Checagens (entre generalização e especializações Calibração e Manutenção) não existe cardinalidade.
```

- Remover Cliente e contrato
- Adicionar minimo, não só maximo
- Remover cardinalidade das especializações

Retirar entidades desnecessárias:
Não incluir as entidades Cliente e Contrato, já que o objetivo é modelar calibração e manutenção de equipamentos de laboratório, e não serviços oferecidos pelos laboratórios.

Corrigir notação de cardinalidade:
Expressar cada cardinalidade usando a notação (mínimo, máximo), e não apenas o máximo. Exemplo:
Entre Laboratório e Equipamento: (1,1) do lado de Equipamento e (0,n) do lado de Laboratório.
Generalização/especialização de Checagens:

Não deve haver cardinalidade na relação de generalização/especialização entre Checagens e suas especializações (Calibração e Manutenção). Estas devem ser modeladas como uma relação hierárquica simples.

----------------------------------------------------

# Modelo logico relacional

## Escrita da sora 
```
Modelo lógico relacional: - a tabela Serviços tem que ter como chave estrangeira #Id_Laboratório (é o lado n de um relacionamento 1:n) - Detém não deve gerar uma tabela, pois é um relacionamento 1:n (a cardinalidade de Fornecedor e Equipamento está trocada: cada Equipamento tem 1 Fornecedor, e cada Fornecedor fornece n Equipamentos) - Possui não deve gerar uma tabela, pois é um relacionamento 1:n (Equipamento deve ter a chave estrangeira de Laboratório, pois é o lado n do relacionamento) - o relacionamento Sofre é n:n, e deve gerar uma tabela - Checagem, assim como Calibração, herda a chave primária de Checagens como chave estrangeira - Equipamento deve conter como chave estrangeira a chave de Laboratório (pois é o lado n de um relacionamento 1:n)

```

Tabela Serviços:

Adicionar a chave estrangeira #Id_Laboratório na tabela Serviços, pois o relacionamento entre Laboratório e Serviços é de 1.

Relacionamento Detém:
Não deve gerar uma tabela separada. Corrigir a cardinalidade:
Cada Equipamento tem 1 Fornecedor, e cada Fornecedor pode fornecer n Equipamentos.
A tabela Equipamento deve conter a chave estrangeira #Id_Fornecedor.

Relacionamento Possui:
Não deve gerar uma tabela separada.
Adicionar a chave estrangeira #Id_Laboratório na tabela Equipamento, já que Laboratório e Equipamento possuem uma relação 1
, onde Equipamento é o lado n.

Relacionamento Sofre:
Este é um relacionamento n
entre Equipamento e Checagem. Deve gerar uma tabela com:
#Id_Equipamento (chave estrangeira)
#Id_Checagem (chave estrangeira)
Tabela Checagem:

A tabela Checagem deve herdar a chave primária #Id_Checagem como chave estrangeira na tabela Calibração e na tabela Manutenção.
Chave estrangeira em Equipamento:

Incluir a chave estrangeira #Id_Laboratório em Equipamento, já que Laboratório é o lado 1 da relação 1.

## Resumo das Correções

1. Modelo ER: Remover entidades desnecessárias (Cliente, Contrato), corrigir cardinalidades para usar a notação (mínimo,máximo) e ajustar a modelagem de generalização/especialização de Checagens.

2. Modelo Lógico Relacional: Corrigir tabelas geradas por relacionamentos (Detém e Possui não geram tabelas), adicionar chaves estrangeiras corretamente, herança de Checagem, e modelar corretamente o relacionamento Sofre como n