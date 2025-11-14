//
//  main.swift
//  rpg apple
//
//  Created by PALOMA JONSON SILVA on 14/11/25.
//
import Foundation

var hp = 20
var ataqueB = 4
var defesa = 2
var xp = 0
var nivel = 0

//base




var jogadorClasse = ""
var jogadorHP = 25
var jogadorAtaque = 6
var jogadorDefesa = 2
var jogadorDefExtra = 0
var jogadorXP = 0




func rolar(_ lados: Int) -> Int {
   Int.random(in: 1...lados)
}


func historiaGeral() {
   print("""
   há semanas, a cidade de são paulo está estranha.
   as pessoas andam sem brilho, quase sem vida.
   a cidade esta mais cinza que o normal quebrando o equilibrio saudavel de uma capital.
   os pombos sao criaturas sagradas colocadas nas cidades para manter o equilibrio entre o fisico e o espiritual, por mais que muitos pombos tenham desistido dessa missao por conta dos 
   só os pombos percebem que algo está errado.
   eles observam tudo de cima dos prédios e fios.
   e perceberam uma coisa mais estranha ainda:
   uma fumaça cinza está drenando os sonhos da cidade.
   você é um pombo que decidiu investigar.
   agora escolha de qual bairro você é.
   """)
}





func historia(_ classe: String) {
   switch classe {
   case "sé":
       print("""
       você é um pombo da sé. Há semanas a praça está pesada e estranha. passos lentos, rostos vazios. os comercios se fecharam e nem os bebados sorriem mais. parece que algo no subsolo está drenando os sonhos.
       """)
   case "paulista":
       print("""
       você é um pombo da paulista. há semanas a avenida perdeu vida.artistas pararam, turistas sem olhar, trabalhadores só arrastam os pés. parece que algo no subsolo está drenando os sonhos.
       """)
   case "ibirapuera":
       print("""
       você é um pombo do ibirapuera. há semanas o parque está apagado.
       vento parado, lago parado, crianças sem imaginação.
        parece que algo no subsolo está drenando os sonhos.
       """)
   default: break
   }
}

func escolherClasse() {
   print("""
   escolha seu tipo de pombo:
   1. sé  — +3 de defesa no próximo turno
   2. paulista — 2 ataques
   3. ibirapuera — +2 hp e perde o turno
   escolha:
   """)
   let op = readLine() ?? ""
   switch op {
   case "1": jogadorClasse = "sé"
   case "2": jogadorClasse = "paulista"
   case "3": jogadorClasse = "ibirapuera"
   default:
       jogadorClasse = "sé"
       print("opção inválida, usando sé")
   }
}



func usarHabilidade() -> (duplo: Bool, perdeTurno: Bool) {
   if jogadorClasse == "sé" {
       print("habilidade: defesa +3 no próximo turno")
       jogadorDefExtra = 3
       return (false, false)
   }
   if jogadorClasse == "paulista" {
       print("habilidade: 2 ataques no turno")
       return (true, false)
   }
   if jogadorClasse == "ibirapuera" {
       print("habilidade: +2 hp e perde turno")
       jogadorHP += 2
       return (false, true)
   }
   return (false, false)
}



func inimigosAleatorio() -> (nome: String, hp: Int, atk: Int, def: Int, xp: Int) {
   let tipo = Int.random(in: 1...3)

   if tipo == 1 {
       return ("vento das 18h", 12, 4, 1, 15)
   }
   if tipo == 2 {
       return ("cachorro caramelo", 18, 5, 2, 25)
   }
   return ("doidinho do centro", 28, 7, 3, 40)
}
func criarBoss() -> (nome: String, hp: Int, atk: Int, def: Int, xp: Int) {
   return ("o acinzentado", 60, 7, 3, 999)
}



func bonus(){
    let omg = Int.random(in: 1...4)
    if omg == 1 && hp < 25 {
        hp = hp + 1
        print("Você achou uns grãos ✨+1 hp✨, agora sua vida é de: \(hp)")
    }
    else if omg == 2 && hp < 22 {
        hp = hp + 3
        print("Você achou migalhas ✨+3 hp✨, agora sua vida é de: \(hp)")
    }
    else if omg == 3 && hp < 19 {
        hp = hp + 6
        print("Você achou pipoca ✨+6 hp✨, agora sua vida é de: \(hp)")
    }
    else if omg == 4 && hp < 15 {
        hp = hp + 10
        print("Você achou pão francês ✨+10 hp✨, agora sua vida é de \(hp)")
    }

}

func batalha(nome: String, hpInicial: Int, atk: Int, def: Int, xp: Int) {
   var inimigoHP = hpInicial
   print("\napareceu: \(nome)\n")
   while inimigoHP > 0 && jogadorHP > 0 {
       print("""
       --- sua vez ---
       seu hp: \(jogadorHP)
       1 atacar
       2 habilidade
       3 defender
       4 fugir
       escolha:
       """)
       let acao = readLine() ?? ""
       var ataqueDuplo = false
       var perdeuTurno = false
       if acao == "1" {
           // ataque normal
       }
       else if acao == "2" {
           let r = usarHabilidade()
           ataqueDuplo = r.duplo
           perdeuTurno = r.perdeTurno
       }
       else if acao == "3" {
           print("você defendeu (+2 defesa)")
           jogadorDefExtra = 2
           perdeuTurno = true
       }
       else if acao == "4" {
           if rolar(20) >= 15 {
               print("você fugiu")
               return
           } else {
               print("falhou em fugir")
           }
       }

       if !perdeuTurno {
           let dano = rolar(6) + jogadorAtaque
           let final = max(0, dano - def)
           print("você causou \(final) de dano")
           inimigoHP -= final
       }
     
       if ataqueDuplo {
           let dano2 = rolar(6) + jogadorAtaque
           let final2 = max(0, dano2 - def)
           print("segundo ataque: \(final2) de dano")
           inimigoHP -= final2
       }
       if inimigoHP <= 0 {
           print("você derrotou \(nome)")
           jogadorXP += xp
           bonus()
           jogadorDefExtra = 0
           return
       }
       
       let danoInimigo = max(0, (rolar(6) + atk) - (jogadorDefesa + jogadorDefExtra))
       print("\(nome) causou \(danoInimigo) de dano")
       jogadorHP -= danoInimigo
       jogadorDefExtra = 0
       if jogadorHP <= 0 {
           print("Você morreu")
           return
       }
   }
}

func iniciarJogo(){
    print("--- RPG Pombo SP - INICIADO ---")
    
    print("")
    historiaGeral()
    print("")
    escolherClasse()
    print("")
    print("")
    historia(jogadorClasse)
    
    print("\n--- Começa a Jornada! ---\n")
 
    
    for i in 1...3 {
        if jogadorHP <= 0 {
            break
        }
        print("\n=== ENCONTRO \(i)/3 ===")
        let inimigo = inimigosAleatorio()
        
        batalha(nome: inimigo.nome, hpInicial: inimigo.hp, atk: inimigo.atk, def: inimigo.def, xp: inimigo.xp)
    }


    if jogadorHP > 0 {
        print("\n=== CHEGADA AO SUBSOLO ===")
        let boss = criarBoss()
        batalha(nome: boss.nome, hpInicial: boss.hp, atk: boss.atk, def: boss.def, xp: boss.xp)
    }

    if jogadorHP > 0 {
        print("\n PARABÉNS! Você salvou os sonhos de São Paulo!")
    } else {
        print("\nFim de Jogo. Tente novamente!")
    }
    
}
iniciarJogo()
