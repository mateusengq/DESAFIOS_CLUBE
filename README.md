# DESAFIO UNIVERSIDADE DOS DADOS
# O QUE E CONSIDERADO "SER AMERICANO" PARA O ELEITOR DOS EUA?

Este desafio foi proposto no Clube da [Universidade dos Dados](https://universidadedosdados.com/) e consiste em reponder algumas questoes a partir de uma base da FiveThirtyEight.

A pesquisa foi realizada entre o período de 15 de setembro a 25 de setembro, focando nas eleições de 2020 (Importante: estes dados não representam uma análise da eleição que ocorrerá este ano, 2024). A base de trabalho possui 5.836 respondentes e 119 variáveis e, para as análises, estou assumindo que corresponde a uma amostra representativa da população. Para a construção dos gráficos foi adotado o R/GGPLOT2, Excel e PowerPoint.

# Visao Geral
Para o público não familiarizado com o eleitor americano, foram criadas duas personas a partir dos dados para contextualizar quem são. Para a caracterização das personas, foi considerado o perfil médio dos respondentes abaixo de 54 anos e acima desta idade.

De um lado, temos o casal John e Lisa com uma idade mediana de 33 anos, brancos e com renda de $75k a $125k, com ensino superior completo. 53% desse público é masculino, por isso a opção de representá-los como um casal.

Do outro lado, temos Ruth e Franklin, com 66 anos e brancos. Ruth ganha menos que $40k e possui ensino médio ou menos, enquanto Franklin ganha mais de $125k e possui ensino superior completo.

![Personas](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/personas.png)

## Parte 1

### P1.1. Qual o perfil da amostra analisada? Verifique a distribuição de idade, gênero, raça, nível educacional e salarial. 
#### P1.1.1. Idade

A idade média dos respondentes é de 51,69 anos, com desvio padrão de 17 anos e uma mediana de 54 anos. A menor idade identificada foi de 22 anos e a maior, 94 anos. Dos respondentes, 205 possuem mais de 80 anos.

No gráfico, é possível notar a presença de duas concentrações da variável idade: a primeira entre os respondentes mais jovens, próximo aos 30 anos, e a segunda, mais acentuada, próxima aos 65 anos.

![Histograma Idade](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/histograma_variavel_idade.png)

#### P1.1.2. Genero
Em relacao ao genero, 49,5% sao mulheres.
![Genero](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/genero.png)


#### P1.1.3. Raca

![Raca](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/proporcao_raca_laranja.png)


#### P1.1.4. Nivel Educacional e Nivel Salarial
40% dos entrevistados possuem "College" e 31% possuem apenas "High School or less". Para a renda, 28% estão na faixa de $75k - $125k, enquanto todas as demais faixas apresentam 24%, demonstrando uma distribuição com percentuais próximos.

![Renda](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/renda_educacao.png)


### P1.2. Assumindo que a amostra representa adequadamente a população americana, qual a raça que possui maior poder aquisitivo? E menor? 
Como há uma predominância de respondentes autodeclarados brancos, optou-se por analisar o percentual de cada faixa de renda dentro de cada classe de "Raça", ou seja, cada classe equivale a 100% dos casos e avalia-se como os respondentes daquela classe estão distribuídos nas faixas de renda.

Os classificados como "Other/Mixed" apresentam uma menor quantidade de respondentes no total, mas, de seus respondentes, 33% estão na faixa "$125k or more". Aproximadamente 60% possuem renda superior a "$75k". Em relação aos autodeclarados brancos, a maior concentração está na faixa de "$75-125k".

Sobre o menor poder aquisitivo, temos que 36% dos negros ganham menos de "$40k" e apenas 15% ganham acima de "$125k", a menor proporção apresentada em todas as classes.

![Renda e Faixa Salarial](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/predominancia_salarial.png)

### P1.3. - Ainda assumindo que temos uma amostra representativa, podemos dizer que nível educacional e poder aquisitivo estão correlacionados? 
Analisando a tabela, percebe-se que ha uma correlacao positiva entre o nivel educacional e o poder aquisitivo.

- Indivíduos com nível educacional "High school or less" têm uma maior proporção de rendas mais baixas (menos de $40k).
- Indivíduos com "Some college" têm uma distribuição mais equilibrada, mas ainda uma proporção significativa nas faixas de renda mais altas.
- Indivíduos com "College" têm a maior proporção nas faixas de renda mais altas ($75-125k e mais de $125k).

![Renda e Nivel Educacional](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/nivel_educacional_renda.png)

Foi realizado um teste Qui-quadrado apenas para avaliar os dados.
- X-squared: 1155.5
- Graus de liberdade (df): 6
- p-valor: < 2.2e-16

Dado o p-valor extremamente pequeno, podemos rejeitar a hipótese nula de que não há associação entre o nível educacional e o poder aquisitivo. Em outras palavras, os dados fornecem evidências fortes de que há uma associação significativa entre nível educacional e poder aquisitivo.


## Parte 2 - O QUE É CONSIDERADO SER UM BOM AMERICANO

### P2.1: Um nível educacional maior implica em maior responsabilidade em relação a votar?
