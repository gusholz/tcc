# Algoritmos Baseados no Design Computacional
Acesso a monografia disponível no link: https://docs.google.com/document/d/10nvZHsbcrD-31PFYjHUbO--69VhWNOh-5Fie-DC_-V4/edit?usp=sharing 

## Algoritmo baseado no Design Paramétrico

Este algoritmo foi inspirado no artista **Mondrian** e funciona da seguinte maneira:

- **Setup:**
  - A tela é ajustada para sua resolução máxima.
  - A cor preta (`#282828`) é atribuída como fundo.
  - A velocidade de execução do código é definida como **quatro quadros por segundo**.
  - Define-se o tamanho da moldura com base no parâmetro `frameSize`.

- **Draw:**
  - Se `iterationEnded` for verdadeiro, a execução do código é finalizada.
  - O tamanho da moldura é atualizado com base no **expoente de Cantor** e no valor de `iterationCount`.
  - Na primeira iteração, o tamanho da moldura equivale ao valor inicial definido no setup.
  - Em cada iteração, o algoritmo desenha **retângulos, círculos e linhas** em posições específicas, dependendo se `iterationCount` é **ímpar ou par**.
  - `iterationCount` é incrementado a cada ciclo até atingir `maxIteration`, encerrando a execução.

---

## Algoritmo baseado no Design Algorítmico

Este algoritmo tem como principal recurso a **captura de áudio**. Ele funciona da seguinte maneira:

- O som é utilizado como **input** para modificar o tamanho de linhas.
- A leitura das ondas sonoras é representada ao longo de um **círculo**.
- **Dimensões maiores** representam amplitudes de som mais elevadas e **dimensões menores**, amplitudes mais baixas.
- O objetivo é explorar um **aspecto sinestésico**, interligando **som, cor e forma**.
- A questão central do algoritmo está na **representação da relação entre esses elementos distintos**, não apenas de forma harmônica, mas também **semântica**.

---

## Algoritmo baseado no Design Generativo

Este algoritmo segue um processo em duas etapas:

### **1. Geração de Vetores em uma Grade**
- Uma grade é criada na superfície da tela.
- Vetores são distribuídos ao longo dessa grade.
- A **direção dos vetores é determinada aleatoriamente**, tornando o algoritmo **não determinístico** (mesmos valores podem gerar resultados diferentes).

### **2. Sistema de Partículas**
- Diversos **círculos** são instanciados e posicionados aleatoriamente.
- Cada partícula se movimenta continuamente, seguindo a **direção do vetor mais próximo**.
- O resultado final é um **padrão orgânico**, gerando **caminhos visuais semelhantes a linhas**.

