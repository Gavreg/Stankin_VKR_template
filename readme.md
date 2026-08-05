# Шаблон выпускной квалификационной работы для студентов кафедры Информационных технологий и вычислительных систем МГТУ "СТАНКИН"

Шаблон выполнен для системы компьютерной вёрстки $\LaTeX$. Полная инструкция по применению шаблона приведена в нем самом (пока ещё нет).
## Необходимое ПО
- Любой редактор $\LaTeX$. Я использую **TexStudio** https://www.texstudio.org/
- Дистрибутив $\LaTeX$. Шаблон разрабатывался и тестировался с использованием **TexLive 2026** под Windows https://www.tug.org/texlive/ . CI гитхаба собирает pdf на последней версии образа [texlive](https://hub.docker.com/r/texlive/texlive) на убунте (cм. dockerfile и build.sh).
- **Python** >=3.14

## Структура шаблона     
### Основные файлы:
|   |   |
|---|---|
| ```main.tex```            | полная ВКР с титульными листами, заданием, основной работой, списком литературы и приложениями.
| ```main_assigment.tex```  | только задание на ВКР. |
| ```main_annotation.tex``` | только аннотация ВКР. |
|   |   |

Для сборки применятся компилятор Xelatex и скрипт latexmk.

 Вся ВКР:
```powershell
latexmk -pdfxe -synctex=1 -interaction=nonstopmode -halt-on-error  --shell-escape -8bit main.tex
```
или только задание:
```powershell
latexmk -pdfxe -synctex=1 -interaction=nonstopmode -halt-on-error  --shell-escape -8bit main_assigment.tex
```
или только аннотация:
```powershell
latexmk -pdfxe -synctex=1 -interaction=nonstopmode -halt-on-error  --shell-escape -8bit main_annotation.tex
```

При использовании Linux или WSL с докером процесс сборки упрощается. Достаточно один раз собрать образ с латехом и нужными шрифтами:

```bash
sudo docker build -t vkrlateximage .
```

и затем вызывать его для сборки нужного документа 

```bash
docker run --rm -v "$PWD":/data vkrlateximage \
        latexmk   -pdfxe interaction=nonstopmode -halt-on-error -8bit --shell-escape -synctex=0  main.tex
```

С учётом списка литературы, оглавления и ссылок документ должен компилироваться несколько раз. Latexmk сам понимает сколько раз ему это делать. Для ручной компиляции придётся вызвать xelatex и biber в такой последовательности:

```
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error  --shell-escape -8bit main.tex
biber main.tex
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error  --shell-escape -8bit main.tex
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error  --shell-escape -8bit main.tex
```
Для задания или аннотации достаточно однократного xelatex.

Обычно специальные редакторы делают многократную компиляцию автоматически.

### Остальные файлы
|   |   |
|---|---|
| ```vkr-config.tex``` |Файл с настройками ВКР. Внесите сюда информацию о себе, теме, руководителе, итд. Информация из него фигурирует в дальнейшей ВКР.|
| ```title.tex``` | Титульный лист, формируется на основании данных из ```vkr-config.tex``` |
| ```assignment.tex``` |Задание на ВКР. Основные сведения берутся из ```vkr-config.tex```. Требует доработки под свою работу: цель, объект, предмет, задачи, и т.п.|
| ```annotation.tex``` |Аннотация к ВКР.|
| ```toc.tex``` |Оглавление. Формируется автоматически.|
| ```intro.tex``` |Введение.|
| ```chX.tex``` |Файлы с главами ВКР. Обычно в ВКР 4 главы. Для изменения количества глав см ```main.tex```.|
| ```images/``` | Папка для изображений. Рекомендуется для каждой отдельной главы создавать свою под-директорию, чтобы избежать свалки. |
| ```outro.tex``` |Заключение.|
| ```biblio.tex``` | Библиография. Файл не требует модификаций. Библиографическая база носится в ```vrkbibliograpgy.bib```. |
| ```appX.tex``` | Приложения. В примере содержится 2 файла  приложений. |
|   |   |

