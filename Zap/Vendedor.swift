//
//  Vendedor.swift
//  Zap
//
//  Created by Matheus Herminio de Carvalho on 30/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import Foundation


class Vendedor {
    var id: String // chave primária
    var nome: String
    var lojaId: String
    var disponivel:String
    init(Id id:String,Nome nome:String,LojaId lojaId:String,Disponivel disponivel:String){
        self.id = id
        self.nome = nome
        self.lojaId = lojaId
        self.disponivel = disponivel
    }
    
}
