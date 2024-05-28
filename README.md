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
Em relacao ao genero, **49,5% sao mulheres**.

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
- X2: 1155.5
- Graus de liberdade (df): 6
- p-valor: < 2.2e-16

Dado o p-valor extremamente pequeno, podemos rejeitar a hipótese nula de que não há associação entre o nível educacional e o poder aquisitivo. Em outras palavras, os dados fornecem evidências fortes de que há uma associação significativa entre nível educacional e poder aquisitivo.


## Parte 2 - O QUE É CONSIDERADO SER UM BOM AMERICANO

### P2.1.: Um nível educacional maior implica em maior responsabilidade em relação a votar?
Inicialmente, os valores "-1" para a "importancia de votar" votar desconsiderados. Foram registrados 35 casos (0.6%) da base total.

Todos os niveis de escolaridade consideram, majoritariamente, votar como muito importante, representando 82% do entrevistados. Nota-se que com a reducao da escolaridade, o "Not at all importante" apresenta um level aumento, ainda que pequeno quando analisado o total de respondentes. 

![Importancia de Votar e Escolaridade](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/importancia_votar_escolaridade_modelo_2_ajuste_cores.png)

### P2.2. Dentre os não-brancos, o que é mais importante para ser um bom americano: votar em eleições, demonstrar a bandeira americana ou apoiar o exército? Existe uma diferença na preferência de não-brancos de maior poder aquisitivo vs menor poder aquisitivo?

Considerando os tres itens avaliados (Votar, Demostrar Bandeira, Apoiar Exercito), a maioria parcela dos respondentes nao-brancos afirma que votar e o mais importante, seguido por apoiar o exercito. E interessante notar que o item "demonstrar bandeira" aparece com quantidades similares para todos os niveis de importancia.

![Importance para ser um bom americano - nao brancos](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/importante_ser_americano_nao_branco.png)

Analisando o gráfico com a divisão por renda, as pessoas com maior renda apresentam maior proporção em relação a votar do que aquelas com menor renda. Embora apresentem proporções diferentes, "votar" aparece em primeiro lugar, "apoiar o exército" em segundo, e "demonstrar a bandeira" como terceiro em relação às proporções.

![Importance para ser um bom americano - nao brancos | Renda](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/importante_ser_americano_renda.png)

*Observacao: para um futuro trabalho, analisar o comportamento de cada grupo, nao considerando o total de nao-brancos para identificar se ha diferencas entre as racas.*

### P2.3. Considerando que respeitar a opinião dos outros (Q2_8) é um indício de tolerância, ao compararmos as gerações de 18-30 anos, 31-50 anos e +51, qual é a mais tolerante e a menos tolerante? 

Pessoas de todas as faixas etárias consideram muito importante respeitar a opinião dos outros. No gráfico abaixo, é possível perceber que, para pessoas mais jovens, há uma discrepância nas "distâncias" entre as barras, ou seja, atribuem menor "importância" a opiniões divergentes do que os adultos.

![Respeitar a opiniao](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/respeitar_opiniao_faixa_etaria.png)

## Parte 3 - - ESCOLHAS PARTIDÁRIAS
### P3.1. Qual escolha partidária, incluindo pessoas sem partido (Q30), possui eleitores mais jovens? E qual possui mais mulheres como apoiadoras?

Os eleitores mais jovens (978 respondentes) destacam-se como apoiadores dos Democratas, representando 36,7%, em seguida, dos independentes correspondente a 26,2%. Nota-se que o apoio aos "Republicanos" e "Outros" apresentam valores absolutos similares.

![Partido politico](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/partido_politico_faixa_etaria.png)

Em relacao as mulheres, temos uma maior apoio no **Partido Democrata**, seguido pelo **Partido Republicano**.

![Mulheres e partidos politicos](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/apoio_feminino_partido.png)

### P3.2. - Qual o perfil do público sem partido (independent ou no preference), em termos de idade e gênero? E dos republicanos? E dos democratas? 

**Genero**

- **Another/No preference (Outro/Sem preferência)**: 54% dos indivíduos que não têm preferência política são mulheres, enquanto 46% são homens.
- **Democratas**: A proporção de mulheres entre os democratas é de 54%, e a de homens é de 45.8%.
- **Independente**: Entre os independentes, 39% são mulheres e 61% são homens.
- **Republicanos**: Os republicanos têm uma proporção de 51% de mulheres e 49.1% de homens.
A proporção de homens e mulheres varia entre os diferentes grupos políticos, com os independentes tendo a maior proporção de homens (61%) e os democratas a maior proporção de mulheres (54%).

**Idade**
- **Another/No preference (Outro/Sem preferência)**: A idade mediana é 42 anos, com uma idade média de 45.3 anos. O desvio padrão é 15.7 anos, indicando a variação na idade dos indivíduos desse grupo. A menor idade é 22 anos e a maior idade é 85 anos.
- **Democratas**: A idade mediana é 55 anos, e a idade média é 51.9 anos, com um desvio padrão de 17.3 anos. A idade varia entre 22 e 94 anos.
- **Independente**: A idade mediana dos independentes é 53 anos, com uma idade média de 51.4 anos e um desvio padrão de 17.3 anos. A idade mínima é 22 anos e a máxima é 92 anos.
- **Republicanos**: A idade mediana é 57 anos, com uma média de 54.7 anos. O desvio padrão é 16.3 anos, e a idade varia entre 22 e 90 anos.
Os republicanos têm a maior idade mediana (57 anos) e média (54.7 anos), enquanto o grupo sem preferência tem as menores idades medianas (42 anos) e médias (45.3 anos).

![Resumo - Perfil/Partido](https://github.com/mateusengq/DESAFIOS_CLUBE/blob/main/GRAFICOS/tabela_perfil_partido.png)

### P3.3. Existe uma correlação entre idade e propensão a votos (voter_category)?

Para avaliar se existe uma correlacao entre a idade e os grupos foi utilizada a ANOVA considerando um nivel de significancia de 5%.
O valor p para voter_category é extremamente pequeno (< 2e-16), indicando que há uma diferença significativa entre as médias dos grupos de voter_category. Isso significa que a variável voter_category tem um efeito significativo sobre a variável resposta.

![image](https://github.com/mateusengq/DESAFIOS_CLUBE/assets/36772525/32321a02-4856-41cf-b3d0-894c4e8bcc49)

Em seguida, foi realizado um teste de Tukey para identificar os grupos que diferem entre si e os resultados indicam que há diferenças significativas entre todas as categorias de voto em termos de idade média. 
- As pessoas que votam "rarely/never" são significativamente mais jovens do que as que votam "always".
- As pessoas que votam "sporadic" são significativamente mais velhas do que as que votam "rarely/never", mas ainda são um pouco mais jovens do que as que votam "always".

![image](https://github.com/mateusengq/DESAFIOS_CLUBE/assets/36772525/5dd63bcc-40fb-4831-9d72-69f1de86f1cc)


### PARTE 4 - ESTRATÉGIAS ELEITORAIS 
Se você fizesse parte da equipe de marketing do partido republicano, qual público você deveria mirar para atrair mais votos para o partido? 

#### a) Foco nas Mulheres Sem Partido

Minha primeira abordagem seria direcionar esforços para as pessoas que não possuem partido, especialmente para as mulheres, pois representam um número significativo de eleitoras. Além disso, como não declaram um partido, podem ser mais propensas a "ouvirem" campanhas de qualquer um dos lados. 
Em segundo lugar, focaria no público que se declara independente, tentando 'fisgar' votos "envergonhados". Provavelmente, há uma parcela da população que se declara "independente" ou "sem partido" por receio de emitir a verdadeira intenção de voto.

#### b) Comunicação com os Jovens

Melhorar a comunicação com os jovens (abaixo de 30 anos). O partido republicano apresenta baixa adesão entre os mais jovens, ao contrário do partido democrata. Uma sugestão seria direcionar campanhas específicas comunicando **diretamente** com esse público.

#### c) Foco nos Votantes Esporádicos

Por fim, direcionar campanhas para os votantes esporádicos, principalmente para o público acima de 51 anos, onde os republicanos possuem uma melhor atuação dentre as faixas etárias analisadas.


---------
**## Apenas teste - Excluir**

**Numeros absolutos**

|                  | Abaixo de 30 anos | De 31 a 50 anos | Acima de 51 anos | Total |
|------------------|-------------------|-----------------|------------------|-------|
| **Always**       | 344               | 182             | 1285             | 1811  |
| **Rarely/Never** | 471               | 514             | 466              | 1451  |
| **Sporadic**     | 174               | 907             | 1493             | 2574  |
| **Total**        | 989               | 1603            | 3244             | 5836  |

**Proporcao**
|                  | Abaixo de 30 anos | De 31 a 50 anos | Acima de 51 anos |
|------------------|-------------------|-----------------|------------------|
| **Always**       | 6%                | 3%              | 22%              |
| **Rarely/Never** | 8%                | 9%              | 8%               |
| **Sporadic**     | 3%                | 16%             | 26%              |

Para tentar responder a essa pergunta, foi adotado o teste qui-quadrado para verificar se existe uma associacao signifitiva entre as variaveis categoricas.
Foi realizado um teste Qui-quadrado apenas para avaliar os dados.
- X2: 881.66
- Graus de liberdade (df): 4
- p-valor: < 1.56 x 10^-18

Dado o p-valor extremamente baixo, muito menor que qualquer nível de significância comum (como 0.05), rejeitamos a hipótese nula de que não há associação entre a idade e a propensão a votos.
Portanto, existe uma associacao significativa entre a idade e a propensão a votos. ​
