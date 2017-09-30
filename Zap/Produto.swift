//
//  Produto.swift
//  Zap
//
//  Created by Matheus Herminio de Carvalho on 29/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import Foundation
import UIKit


class Produto {
    var codigo: String // chave primária
    var lojaId: String
    var nome: String
    var descricao:String
    var imagem: UIImage
    
    init(Nome nome:String,LojaId lojaId:String,Descricao descricao:String ,Imagem imagem: UIImage){
        self.codigo = ""
        self.lojaId = lojaId
        self.nome = nome
        self.descricao = descricao
        self.imagem = imagem
    }
    
    func gerarCodigo() -> String {
        
        self.codigo = "XC45"
        
        return "XC45"
    }
}




