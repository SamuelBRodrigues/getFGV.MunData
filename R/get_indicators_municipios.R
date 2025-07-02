#' Indicadores Municipais
#'
#' Essa função retorna o código do indicador na API da plataforma FGV - Municípios
#' de acordo com o nome dos indicadores presentes na plataforma. O código do indicador
#' é usado na construção da requisição para a extração dos dados.
#'
#' @param indicator_name Um character com o nome do indicador municipal da plataforma
#' FGV - Municipios.
#'
#' @returns Um character com o código do indicador.
#' @export
#'
#' @examples
#' \dontrun{
#'  # Pegando o código do indicador `Índice GINI`
#'   indicator_code <- get_indicators_municipios(indicator_name = "Índice GINI")
#' }
get_indicators_municipios <- function(indicator_name){

  indicators_list <- list(
    # População ----
    ## Qual a população com base no CENSO?
    "População e Variações" = "6f3ef77ac0e3619e98159e9b6febf557",
    "Variação Percentual" = "eb163727917cbba1eea208541a643e74",
    ## Como a população do Município se distribui nas áreas urbana e rural nos últimos censos demográficos?
    "População total, urbana e rural" = "1534b76d325a8f591b52d302e7181331",
    ## Qual a estrutura etária da população
    "Pirâmide Etária" = "ca46c1b9512a7a8315fa3c5a946e8265",
    "Projeção da população por faixa etária" = "46ba9f2a6976570b0353203ec4474217",
    ## Qual a evolução de proporção de Jovens, idosos com relação a população em idade ativa?
    "Proporção de jovens e idosos dependentes" = "3b8a614226a953a8cd9526fca6fe9ba5",
    "Quantidade de jovens, pessoas em idade ativa e idosos" = "45fbc6d3e05ebd93369ce542e8f2322d",
    # PIB
    ## Como é a distribuição de renda no município?
    "Índice GINI" = "b1d10e7bafa4421218a51b1e1f1b0ba2",
    ## Qual o Produto Interno Bruto do Município sua evolução, composição e valor per capita?
    "Evolução do Produto Interno Bruto e seus componentes" = "eae27d77ca20db309e056e3d2dcd7d69",
    "Evolução do Produto Interno Bruto" = "69adc1e107f7f7d035d7baf04342e1ca",
    "Produto Interno Bruto per capita" = "7eabe3a1649ffa2b3ff8c02ebfd5659f",
    "Composição do PIB em 2021" = "091d584fced301b442654dd8c23b3fc9",
    ## Quantas são as entidades, os empregos e as remunerações locais?
    "Estatísticas do Cadastro Central de Empresa" = "d96409bf894217686ba124d7356686c9",

    # Finaças ----
    ## Recursos
    ### Quanto o município teve para gastar?
    "Total das receitas do município" = "46864c4a46ee441bc9a22edad94782ef",
    "Total das receitas do município (milhões de reais)" = "46864c4a46ee441bc9a22edad94782ef_2",
    ### Quanto o município teve para gastar com cada um dos seus habitantes?
    "Valor disponível para gastos por habitante" = "9e9833a13ddcb5cb39fd3ed8cecaae07_2",
    ### De onde vieram os recursos do município?
    "Origem dos recursos financeiros (milhões de reais)" = "77d5595b5cbeaa01e9ba2c4ee7200afa_2",
    "Origem dos recursos financeiros (%)" = "77d5595b5cbeaa01e9ba2c4ee7200afa_3",
    ### Quanto cada esfera aportou por habitante do município?
    "Aporte financeiro de cada esfera de governo por habitante (R$1,00)" = "f06d5f18cc525df92b0b53b17a0656ec_1",
    ### Como o municípop gerou os próprios recursos financeiros?
    "Origem dos recursos financeiros próprios (Proporção)" = "325c6a85a828b64c61f2298ade21c3c5_2",
    "Origem dos recursos financeiros próprios (milhões de reais)" = "325c6a85a828b64c61f2298ade21c3c5_1",
    ### Quais recursos financeiros o município recebeu do Governo Federal?
    "Recursos financeiros do Governo Federal (Proporção)" = "17747a1fb77b21365114dd036be48f1a",
    "Recursos financeiros do Governo Federal (milhões de reais)" = "17747a1fb77b21365114dd036be48f1a_2",
    ### Quais recursos financeiros o município recebeu do Estado?
    "Recursos financeiros do Estado (Proporção)" = "aaeb689484d1f5e3cb21f9d496f7a94e",
    "Recursos financeiros do Estado (milhões de reais)" = "aaeb689484d1f5e3cb21f9d496f7a94e_2",
    ### Quais as Transferência financeiras específicas para educação/FNDE?
    "Recursos financeiros transferidos do FNDE (Proporção)" = "2d2821188c9128cc010957f68ffb6234",
    "Recursos financeiros transferidos do FNDE (milhões de reais)" = "2d2821188c9128cc010957f68ffb6234_2",

    ## Gastos
    ### Como o município gastou seus recursos?
    "Como o município gastou os recursos?" = "3dd80f9c739914060de166bb35554267",
    "Natureza do Gasto (Em milhões)" = "3dd80f9c739914060de166bb35554267_2",
    ### Qual a composição dos gastos com pessoa?
    "Qual a composição dos gastos com pessoa?" = "26b521290b45a7ea6a579449a69e54aa",
    "Gasto com Pessoal (Em milhões)" = "26b521290b45a7ea6a579449a69e54aa_2",
    ### Qual a composição dos gastos de custeio do município
    "Gastos de Custeio (Em Milhões)" = "0f8653b71cf9e02b69b9ed4b74b65411",
    ### Qual a composição dos gastos com investimentos e inversões?
    "Qual a composição dos gastos com investimentos e inversões?" = "8ae66caa131bcad18382bf4d341df48d",
    "Gastos com Investimentos e Inversões (Em milhões)" = "8c19f571e251e61cb8dd3612f26d5ecf",
    ### Gastos com Funções de Estado e sua representação?
    "Gastos com Funções de Estado e sua representação" = "2f2b265625d76a6704b08093c652fd79",
    "Gastos por habitante nas funções do Estado e sua representação" = "310dcbbf4cce62f762a2aaa148d556bd",
    ### Quais os gastos com direitos sociais constitucionais?
    "Gastos com direitos sociais constitucionais" = "f9b902fc3289af4dd08de5d1de54f68f",
    "Gastos por habitante com os direitos sociais constitucionais" = "357a6fdf7642bf815a88822c447d9dc4",
    ### Quais os gastos com Investimento na sociedade e seus direitos?
    "Gastos com Investimento na sociedade e seus direitos" = "04025959b191f8f9de3f924f0940515f",
    "Gastos por habitante com os direitos sociais constitucionais" = "3dd48ab31d016ffcbf3314df2b3cb9ce",
    ### Quais os gastos com Infraestrutura Social?
    "Gastos com Infraestrutura Social" = "3ad7c2ebb96fcba7cda0cf54a2e802f5",
    "Gastos por habitante com Infraestrutura Social" = "d81f9c1be2e08964bf9f24b15f0e4900",
    ### Quais os gastos em Economia?
    "Gastos em Economia" = "c5ff2543b53f4cc0ad3819a36752467b",
    "Gastos por habitante com Economia" = "0bb4aec1710521c12ee76289d9440817",
    ### Quais os gastos com Logística?
    "Gasto com Logística" = "efe937780e95574250dabe07151bdc23",
    "Gastos por habitante com Logística" = "138bb0696595b338afbab333c555292a",
    ### Quais os gastos  com Economia e Sociedade do Futuro?
    "Gasto  com Economia e Sociedade do Futuro" = "82cec96096d4281b7c95cd7e74623496",
    "Gastos por habitante  com Economia e Sociedade do Futuro" = "fb7b9ffa5462084c5f4e7e85a093e6d7",
    ### Quais os gastos com Administração Pública?
    "Gasto com Administração Pública" = "c058f544c737782deacefa532d9add4c",
    "Gastos por habitante  com Administração Pública" = "52720e003547c70561bf5e03b95aa99f",
    ### Quas os gastos com Encargos de Estado?
    "Gasto com Encargos de Estado" = "00411460f7c92d2124a67ea0f4cb5f85",
    "Gastos por habitante com Encargos de Estado" = "9be40cee5b0eee1462c82c6964087ff9",
    ## Finanças do Exercício
    ### Qual a situação dos restos a pagar até o bimestre atual?
    "Restos a Pagar" = "f57a2f557b098c43f11ab969efe1504b",
    ### Qual o resultado primário até o bimestre atual?
    "Resultado Primário" = "b56a18e0eacdf51aa2a5306b0f533204",

    # Legalidades ----
    ## Qual a capidade de pagamento do município (STN)?
    "Qual a capacidade de pagamento do municipio" = "c24cd76e1ce41366a4bbe8a49b02a028",

    # Educação ----
    ## Qual o total de matrículas no município
    "Ensino Infantil" = "502e4a16930e414107ee22b6198c578f",
    "Ensino Fundamental" = "cfa0860e83a4c3a763a7e62d825349f7",
    "Ensino Médio e Educação Profissional" = "a4f23670e1833f3fdb077ca70bbd5d66",
    ## Gasto total com educação (Por matrícula)?
    "Gasto total com educação (Por matrícula)" = "06138bc5af6023646ede0e1f7c1eac75",
    "Gasto total em educação por matrícula" = "39059724f73a9969845dfe4146c5660e",
    "Gastos com educação (por subfunção)" = "7f100b7b36092fb9b06dfb4fac360931",
    ## Qual a razão entre o número de matrículas e população em idade escolar para cada etapa?
    "Taxa de Frequência Escolar % (Pré-Escola)" = "c0e190d8267e36708f955d7ab048990d",
    "Taxa de Frequência Escolar % (Fundamental)" = "ec8ce6abb3e952a85b8551ba726a1227",
    "Taxa de Frequência Escolar % (Médio)" = "060ad92489947d410d897474079c1477",
    "Taxa de Frequência Escolar % (Superior)" = "bcbe3365e6ac95ea2c0343a2395834dd",
    ## Qual o nível de complexidade das escolas?
    "Percentual de escolas por nível de complexidade" = "36660e59856b4de58a219bcf4e27eba3",
    ## Qual a distribuição dos docentes do município por tipo de vúnculo empregatício?
    "Total e percentual de docentes por vínculo no município" = "ef0d3930a7b6c95bd2b32ed45989c61f",
    ## Qual a escolaridade dos docentes do município?
    "Total e percentual de professores no município por escolaridade" = "34ed066df378efacc9b924ec161e7639",
    ## Qual a remuneração média dos professores no município
    "Remuneração média dos docentes" = "758874998f5bd0c393da094e1967a72b",
    ## Qual o gasto com educação (por habitante)?
    "Gasto total em educação por habitante" = "8efb100a295c0c690931222ff4467bb8",
    ## Qual a taxa de aprovação dos alunos no Ensino Fundamental
    "Taxa de Aprovação - Ensino Fundamental - Anos Iniciais" = "c52f1bd66cc19d05628bd8bf27af3ad6",
    "Taxa de Aprovação - Ensino Fundamental - Anos Finais" = "fe131d7f5a6b38b23cc967316c13dae2",
    "Taxa de Aprovação - Ensino Médio" = "f718499c1c8cef6730f9fd03c8125cab",
    ## Qual a nota padronizada no Sistema de Avaliação da Educação Básica (SAEB) obtida pelos alunos do Ensino Fundamnental?
    "SAEB - Ensino Fundamental - Anos Iniciais" = "01161aaa0b6d1345dd8fe4e481144d84",
    "SAEB - Ensino Fundamental - Anos Finais" = "539fd53b59e3bb12d203f45a912eeaf2",
    ## Qual IDEB observado no município e meta das demais redes nos anos de 2021 e 2023?
    "IDEB Observado e Meta das redes no Estado - Anos Iniciais" = "cf67355a3333e6e143439161adc2d82e",
    "IDEB Observado e Meta das redes no Estado - Anos Finais" = "07563a3fe3bbe7e3ba84431ad9d055af",
    ## Qual o desempenho nos indicadores que compõem os IDEB nos anos de 2021 e 2023?
    "Decomposição do IDEB - Anos Iniciais" = "37f0e884fbad9667e38940169d0a3c95",
    "Decomposição do IDEB - Anos Finais" = "d64a340bcb633f536d56e51874281454",
    ## Qual o esforço necessário para a rede municipal alcançar a meta das demais redes de ensino nos anos de 2021 e 2023?
    "IDEB e Esforço da rede municipal para alcançar a meta das demais redes no Estado - Anos Iniciais" = "0fcbc61acd0479dc77e3cccc0f5ffca7",
    "IDEB e Esforço da rede municipal para alcançar a meta das demais redes no Estado - Anos Finais" = "298f95e1bf9136124592c8d4825a06fc",
    ## Qual o esforço necessário para a rede municipal alcançar os níveis da Escala SAEB de Língua Portugues e Matemática nos anos de 2021 e 2023?
    "Indicadores de esforço das avaliações do SAEB - Anos Iniciais" = "38913e1d6a7b94cb0f55994f679f5956",
    "Indicadores de esforço das avaliações do SAEB - Anos Finais" = "ebd9629fc3ae5e9f6611e2ee05a31cef",
    # A população dos municípios tem quantos anos de estudo?
    "Anos de estudo" = "115f89503138416a242f40fb7d7f338e",
    # Qual a taxa de anafalbetismo do município?
    "TAXA DE ANALFABETISMO DE PESSOAS DE 15 ANOS OU MAIS DE IDADE" = "e96ed478dab8595a7dbda4cbcbee168f",

    # Saúde ----
    ## Qual a quantidade de médicos no município?
    "Médicos por  mil habitantes" = "6c9882bbac1c7093bd25041881277658",
    ## Qual a cobertura do programa Estratégia de Saúde da Família?
    "Atenção Básica" = "e4a6222cdb5b34375400904f03d8e6a5",
    "Agentes Comunitários de Saúde" = "cb70ab375662576bd1ac5aaf16b3fca4",
    "Saúde Bucal" = "9188905e74c28e489b44e954ec0b9bca",
    ## A quantidade de leitos para internação e UTI é adequada para o município?
    "Leitos de UTI por mil habitantes" = "0266e33d3f546cb5436a10798e657d97",
    "Leitos de Internação por  mil habitantes" = "38db3aed920cf82ab059bfccbd02be6a",
    "Leitos de Internação e UTIs" = "621bf66ddb7c962aa0d22ac97d69b793",
    ## Qual o gasto com saúde por habitante?
    "Gasto total em saúde por habitante" = "f7664060cc52bc6f3d620bcedc94a4b6",
    "Gastos com saúde (por subfunção)" = "eda80a3d5b344bc40f3bc04f65b7a357",
    ## Qual a cobertura vacinal do município?
    "Cobertura Vacinal" = "19f3cd308f1455b3fa09a282e0d496f4",
    ## Qual a mortalidade infantil no município (dados IDH)
    "Até 1 ano de idade" = "74db120f0a8e5646ef5a30154e9f6deb",
    "Até 5 anos de idade" = "57aeee35c98205091e18d1140e9f38cf",
    ## Qual a mortalidade infantil no municipio (SUS)
    "Percentual de mortes em relação aos nascidos vivos" = "555d6702c950ecb729a966504af0a635",
    ## Qual o número médio de filho de uma mulher no período reprodutivo (15 a 49 anos de idade)?
    "Número médio de filhos" = "be83ab3ecd0db773eb2dc1b0a17836a1",
    ## Qual a expectativa de vida?
    "Expectativa de Vida ao Nascer" = "13fe9d84310e77f13a6d184dbf1232f3",
    "Probabilidade (%) de Sobrevivência até 40 anos" = "d1c38a09acc34845c6be3a127a5aacaf",
    "Probabilidade (%) de Sobrevivência até 60 anos" = "9cfdf10e8fc047a44b08ed031e1f0ed1",
    "Probabilidade de sobrevivência (%)" = "705f2172834666788607efbfca35afb3",
    ## Qual o índice de Desenvolviemnto Humano - IDH (logenvidade)?
    "IDHM - Longevidade" = "9b04d152845ec0a378394003c96da594",

    ## Governança ---- Dados de governança não são a nível municipal.
    ### Administração Pública
    #### Qual a composição do quadro de pessoal da administração direta e indireta nos municípios brasileiros?
    #"Pessoal da administração direta por faixa populacional nos municípios brasileiros" = "7a614fd06c325499f1680b9896beedeb",
    #"Pessoal da administração direta por grandes regiões nos municípios brasileiros" = "00ec53c4682d36f5c4359f4ae7bd7ba1",
    #"Pessoal da administração indireta por faixa populacional no Brasil" = "db8e1af0cb3aca1ae2d0018624204529",
    #"Pessoal da administração indireta por grandes regiões no Brasil" = "4f6ffe13a5d75b2d6a3923922b3922e5",
    #### Qual o perfil de sexo, cor e raça dos gestores municipais, por faixa populacional do municípios e grande região geográfica?
    #"Quantidade e Percentual de Gestores Municipais Segundo Sexo, Cor e Raça, por Faixa Populacional" = "432aca3a1e345e339f35a30c8f65edce",
    #"Quantidade e Percentual de Gestores Municipais Segundo Sexo, Cor e Raça, por Grandes Regiões" = "a01a0380ca3c61428c26a231f0e49a09",
    #"Percentual de gestores por área governamental, sexo e raça/cor" = "4f4adcbf8c6f66dcfc8a3282ac2bf10a",
    ### Defesa Civil, Segurança e Integração Social
    ####
    ### Educação
    #### Quais as quantidades de alunos e de docentes dos municipios brasileiros, por faixa populacional dos municípios e por grande região geográfica?
    #"Quantidade de Professores e Percentual de Participação por Tipo de Vínculo, por Faixa Populacional" = "d296c101daa88a51f6ca8cfc1ac79b50",
    #"Quantidade de Professores e Percentual de Participação por Tipo de Vínculo, por Grandes Regiões" = "0584ce565c824b7b7f50282d9a19945b",
    #### Qual a quantidade de docentes por tipo de vínculo dos municipios brasileiros, por faixa populacional dos municípios e por grande regiões geográficas?
    #"Percentual de professores por vínculo nos municípios brasileiros" = "26e359e83860db1d11b6acca57d8ea88",
    #"Percentual de professores por vínculo e grandes regiões nos municípios brasileiros" = "dc912a253d1e9ba40e2c597ed2376640",
    #### Qual a escolaridade dos docentes dos municipios brasileiros, por faixa populacional dos municípios e por grande região geográfica?
    #"Quantidade de Docentes e Percentual de Escolaridade, por Faixa Populacional" = "94f6d7e04a4d452035300f18b984988c",
    #"Quantidade de Docentes e Percentual de Escolaridade, por Grandes Regiões" = "d9fc5b73a8d78fad3d6dffe419384e70",
    #### Qual a remuneração média dos docentes da educação básica dos municipios brasileiros, por faixa populacional dos municípios e por grande região geográfica?
    #"Remuneração Média dos Docentes nos Municípios Brasileiros, por Faixa Populacional" = "950a4152c2b4aa3ad78bdd6b366cc179",
    #"Remuneração Média dos Docentes nos Municípios Brasileiros, por Grandes Regiões" = "c86a7ee3d8ef0b551ed58e354a836f2b",
    ### Finanças
    #### Quanto os municípios brasileiros tiveram para gastar?
    #"Disponibilidade de Recursos dos Municípios" = "faa9afea49ef2ff029a833cccc778fd0",
    #"Disponibilidade de Recursos dos Municípios por grandes regiões" = "3c7781a36bcd6cf08c11a970fbe0e2a6",
    #### Qual o gasto por habitante dos municípios brasileiros com o cumprimento das funções de Estado e sua representação, por faixa populacional dos municípios e grandes região geográfica?
    #"Gasto por habitante nas funções do Estado e sua Representação dos Municípios Brasileiros, por Faixa Populacional" = "6da37dd3139aa4d9aa55b8d237ec5d4a",
    #"Gasto por habitante nas funções do Estado e sua Representação dos Municípios Brasileiros, por Grandes Regiões" = "5a4b25aaed25c2ee1b74de72dc03c14e",
    #### Qual o gasto por habitante dos municípios brasileiros com os direitos constitucionais, por faixa populacional dos municípios e grande região geográfica?
    #"Gasto por habitante com os direitos sociais constitucionais dos Municípios Brasileiros, por Faixa Populacionais" = "819f46e52c25763a55cc642422644317",
    #"Gasto por habitante com os direitos sociais constitucionais dos Municípios Brasileiros, por Grandes Regiões" = "f73b76ce8949fe29bf2a537cfa420e8f",
    #### Qual o gasto por habitante dos municípios brasileiros com investimento na sociedade, por faixa populacional dos municípios e grande região geográfica?
    #"Gasto por habitante com Investimento na Sociedade e seus Direitos dos Municípios Brasileiros, por Faixa Populacional" = "58238e9ae2dd305d79c2ebc8c1883422",
    #"Gasto por habitante com Investimento na Sociedade e seus Direitos dos Municípios Brasileiros, por Grandes Regiões" = "70c639df5e30bdee440e4cdf599fec2b",
    #### Qual o gasto por habitante dos municípios brasileiros com infraestrutura social, por faixa populacional dos municípios e grande região geográfica?
    #"Gasto por habitante com Infraestrutura Social dos Municípios Brasileiros, por Faixa Populacional" = "13f9896df61279c928f19721878fac41",
    #"Gasto por habitante com Infraestrutura Social dos Municípios Brasileiros, por Grandes Regiões" = "28f0b864598a1291557bed248a998d4e",
    #### Qual o gasto por habitante dos municípios brasileiros com funções econômicas, por faixa populacional dos municípios e grande região geográfica?
    #"Gasto por habitante com Economia dos Municípios Brasileiros, por Faixa Populacional" = "9de6d14fff9806d4bcd1ef555be766cd",
    #"Gasto por habitante com Economia dos Municípios Brasileiros, por Grandes Regiões" = "1543843a4723ed2ab08e18053ae6dc5b",
    #### Qual o gasto por habitante dos municípios brasileiros com logística, por faixa populacional dos municípios e grande região geográfica?
    #"Gasto por habitante com Logística dos Municípios Brasileiros, por Faixa Populacional" = "8dd48d6a2e2cad213179a3992c0be53c",
    #"Gasto por habitante com Logística dos Municípios Brasileiros, por Grandes Regiões" = "f8c1f23d6a8d8d7904fc0ea8e066b3bb",
    #### Qual o gasto por habitante dos municípios brasileiros com economia e sociedade do futuro, por faixa populacional dos municípios e grande região geográfica?
    #"Gasto por habitante com Economia e Sociedade do Futuro dos Municípios Brasileiros, por Faixa Populacional" = "aa942ab2bfa6ebda4840e7360ce6e7ef",
    #"Gasto por habitante com Economia e Sociedade do Futuro dos Municípios Brasileiros, por Grandes Regiões" = "e46de7e1bcaaced9a54f1e9d0d2f800d",
    #### Qual o gasto por habitante dos municípios brasileiros com administração, por faixa populacional dos municípios e grande região geográfica?
    #"Gasto por habitante com Administração dos Municípios Brasileiros, por Faixa Populacional" = "c3e878e27f52e2a57ace4d9a76fd9acf",
    #"Gasto por habitante com Administração dos Municípios Brasileiros, por Grandes Regiões" = "b7b16ecf8ca53723593894116071700c",
    #### Qual o gasto por habitante dos municípios brasileiros com encargos, por faixa populacional dos municípios e grande região geográfica?
    #"Gasto por Habitante com Encargos dos Municípios Brasileiros, por Faixa Populacional" = "5ef698cd9fe650923ea331c15af3b160",
    #"Gasto por Habitante com Encargos dos Municípios Brasileiros, por Grandes Regiões" = "352fe25daf686bdb4edca223c921acea",
    #### Qual o gasto por habitante com saúde dos municípios brasileiros, por faixa populacional dos municípios e grande região geográfica?
    #"Gasto por Habitante com Saúde dos Municípios Brasileiros, por Faixa Populacional" = "e56954b4f6347e897f954495eab16a88",
    #"Gasto por Habitante com Saúde dos Municípios Brasileiros, por Grandes Regiões" = "816b112c6105b3ebd537828a39af4818",
    #### Qual o gasto por habitante com educação básica dos municípios brasileiros, por faixa populacional dos municípios e grande região geográfica?
    #"Gasto por Habitante com Educação Básica dos Municípios Brasileiros, por Faixa Populacional" = "69cb3ea317a32c4e6143e665fdb20b14",
    #"Gasto por Habitante com Educação Básica dos Municípios Brasileiros, por Grandes Regiões" = "bbf94b34eb32268ada57a3be5062fe7d",
    #### Qual o gasto por matrícula da educação básica dos municípios brasileiros, por faixa populacional dos municípios e grande região geográfica?
    #"Gasto por Matrícula com Educação básica dos Municípios Brasileiros, por Faixa Populacional" = "8f121ce07d74717e0b1f21d122e04521",
    #"Gasto por Matrícula com Educação básica dos Municípios Brasileiros, por Grandes Regiões" = "18d8042386b79e2c279fd162df0205c8",
    #### Qual a capacidade da arrecadação própria de custear as despesas com pessoal ativo, por faixa populacional dos municípios e grande região?
    #"Quantidade de Municípios por Faixa de Cobertura por Faixa Populacional" = "6ecbdd6ec859d284dc13885a37ce8d81",
    #"Quantidade de Municípios por Faixa de Cobertura por Grandes Regiões" = "18997733ec258a9fcaf239cc55d53363",
    #"Relação Entre Receitas Próprias e Despesas com Pessoal Ativo por Faixa Populacional" = "8d7d8ee069cb0cbbf816bbb65d56947e",
    #"Relação Entre Receitas Próprias e Despesas com Pessoal Ativo por Grandes Regiões" = "75fc093c0ee742f6dddaa13fff98f104",
    ### População e Renda
    #### Qual a evolução da quantidade de municípios e suas correspondentes populações, por faixa populacional dos municípios e grande região geográfica?
    #"Distribuição de Municípios e População, por Faixa Populacional" = "8cb22bdd0b7ba1ab13d742e22eed8da2",
    #"Distribuição de Municípios e População, por Grandes Regiões" = "f4f6dce2f3a0f9dada0c2b5b66452017",
    #"Distribuição de municípios e população - Região Norte" = "0deb1c54814305ca9ad266f53bc82511",
    #"Distribuição de municípios e população - Região Nordeste" = "66808e327dc79d135ba18e051673d906",
    #"Distribuição de municípios e população - Região Sudeste" = "42e7aaa88b48137a16a1acd04ed91125",
    #"Distribuição de municípios e população - Região Sul" = "8fe0093bb30d6f8c31474bd0764e6ac0",
    #"Distribuição de municípios e população - Região Centro-Oeste" = "41ae36ecb9b3eee609d05b90c14222fb",
    #### Qual o Produto Interno Bruto – PIB por habitante dos municípios brasileiros, por faixa populacional dos municípios e grande região geográfica?
    #"PIB por Habitante dos Municípios Brasileiros, por Faixa Populacional" = "0d0fd7c6e093f7b804fa0150b875b868",
    #"PIB por Habitante dos Municípios Brasileiros, por Grandes Regiões" = "a96b65a721e561e1e3de768ac819ffbb",

    # Gestão de Pessoas ----
    ## Qual a composição do quadro de pessoal da administração direta e indireta?
    "Pessoal da administração direta por faixa populacional no estado e município" = "4734ba6f3de83d861c3176a6273cac6d",
    "Composição do pessoal da administração direta" = "d947bf06a885db0d477d707121934ff8",
    "Pessoal da administração indireta por faixa populacional no estado e município" = "20f07591c6fcb220ffe637cda29bb3f6",
    "Composição do pessoal da administração indireta" = "07cdfd23373b17c6b337251c22b7ea57",
    ## Qual o perfil dos gestores municipais?
    "Proporção de gestores segundo sexo nos municípios do estado" = "cd00692c3bfe59267d5ecfac5310286c",
    "Proporção por raça nos municípios do estado" = "6faa8040da20ef399b63a72d0e4ab575",
    "Proporção de gestores por faixa etária" = "fe73f687e5bc5280214e0486b273a5f9"

  )

  indicator <- indicators_list[indicator_name] |> purrr::pluck(1)
  return(indicator)

}
