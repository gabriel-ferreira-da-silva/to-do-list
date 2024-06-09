# README

to-do app implementado com ruby on rails. Video explicando o projeto disponivel 

[neste diretorio do github]: https://github.com/gabriel-ferreira-da-silva/to-do-list/blob/main/video.mp4



![](https://github.com/gabriel-ferreira-da-silva/to-do-list/blob/main/imagens/img1.png)

![](https://github.com/gabriel-ferreira-da-silva/to-do-list/blob/main/imagens/img2.png)

![](https://github.com/gabriel-ferreira-da-silva/to-do-list/blob/main/imagens/img3.png)



# to do

o backend foi implementado com mysql2 com duas tabelas Tarefa e Membro com banco de dados local. As configurações estao presentes em database.yml

```
production:
 adapter: mysql2
 database: Railsdb
 username: myuser
 password: myuser
 host: localhost
 encoding: utf8
```



validações de cada classe estão presentes em app/models

```
class Tarefa < ApplicationRecord
  validates :nome, :descricao, :finalizada, :prioridade, :membro, presence: true

  validates :prioridade, inclusion: { in: %w(baixa media alta), message: "%{value} is not a valid priority" }
  validates :finalizada, inclusion: { in: %w(true false), message: "%{value} is not a valid final atribution" }

  validates_length_of :nome, maximum: 50, minimum: 5, message: "nome deve ter entre 5 e 50 caracteres"
  validates_length_of :descricao, maximum: 140, message: "descricao deve ter no maximo 140 caracters"

end
```







