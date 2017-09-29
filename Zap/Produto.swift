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
    var loja: String
    var vendedor: String
    var nome: String
    var descricao:String
    var imagem: UIImage
    
    init(Loja loja:String,Vendedor vendedor:String,Nome nome:String,Descricao descricao:String,Imagem imagem: UIImage){
        self.loja = loja
        self.vendedor = vendedor
        self.nome = nome
        self.descricao = descricao
        self.imagem = imagem
    }
}
