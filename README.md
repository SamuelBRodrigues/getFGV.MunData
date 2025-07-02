# getFGV.MunData

<!-- badges: start -->

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

<!-- badges: end -->

O objetivo do pacote é extrair os dados de indicadores municipais da plataforma [FGV - Municípios](https://municipios.fgv.br/indicadores), facilitando esse acesso aos dados. Para ter uma visão da estrutura e nome dos indicadores ver a tabela [FGV Municipios Estrutura Indicadores](https://docs.google.com/spreadsheets/d/1d1pryHMYUw5uSqIz6EX9VX1E7XefpZn0gdHrqJPB5Tg/edit?usp=sharing). (Atualmente os indicadores do tipo **Governança** não são contemplados no pacote devido a não seres dados a nível municipal)

**getFGV.MunData** utiliza o pacote **httr2** para executar requisições em paralelo para API da plataforma e extrair os dados.

## Funções

O pacote hoje conta com as funções:

-   **get_indicator_municipios** - Função que retorna o código do indicador na API de acordo com o nome do indicador.

-   **get_mun_data** - Função que extrai os dados dos indicadores da API da plataforma FGV-Município.

# Instalação

```{r}
# Instalando o pacote
remotes::install_github("SamuelBRodrigues/getFGV.MunData")
```

# Uso

Para usar o pacote **getFGV.MunData** utilize a função \`**get_mun_data** \`

```{r}
# Extraindo os dados dos indicadores de `Gasto total em educação por matrícula` e `Médicos por  mil habitantes` para as capitais do Nordeste pelos nomes dos indicadores
data <- get_mun_data(
  cod_ibge = c("2704302", "2611606", "2927408", "2507507", "2800308", "2211001", "2304400", "2408102", "2111300"),
  indicator_name = c("Gasto total em educação por matrícula", "Médicos por  mil habitantes")
)

# Extraindos os dados do indicador `Leitos de UTI por mil habitantes` pelo código do indicador na API para o município de Maceió - AL
data <- get_mun_data(
  cod_ibge = c("2704302"),
  indicator_code = c("0266e33d3f546cb5436a10798e657d97")
)

# Extraindo os dados de todos os indicadores disponíveis no pacote para todos os municípios
data_full <- get_mun_data()
```

A função utiliza ou nome do indicador ou o código, uma vez que o nome do indicador é usado o argumento contendo o código do indicador é desconsiderado. Caso nenhum nome ou código de indicador seja passado para a função, será utilizado todos os códigos dos indicadores disponíveis como argumento.

Se nenhum codigo do ibge for passado para a função, a função extrairá os dados para todos os municípios do Brasil disponível na plataforma.

Para detalhes sobre cada função, consulte a documentação interna do pacote.

Licença Este pacote é distribuído sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

Autor: Samuel Rodrigues ([sam.baraque\@gmail.com](mailto:sam.baraque@gmail.com)).
