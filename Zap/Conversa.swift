//
//  Conversa.swift
//  Zap
//
//  Created by Matheus Herminio de Carvalho on 30/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import Foundation


class Conversa {
    var clienteId: String // chave composta
    var produtoId: String //chave composta
    //var lojaId: String , precisamso discutir
    var mensagens: [Mensagens]
    var vendedorId:String
   
    init(ClienteId clienteId:String,ProdutoId produtoId:String,Mensagens mensagens: [Mensagens],VendedorId vendedorId:String){
        self.clienteId = clienteId
        self.produtoId = produtoId
        self.mensagens = mensagens
        self.vendedorId = vendedorId
    }
    
}


class Mensagens{
    var id: String //eu penso que pode ser Int, como se fosse um contador
    var data: String
    var vendedorId: String
    var texto:String
     //eu penso que os ids irao funcionar com contador , provisório
    init(Id id:String,Data data:String,VendedorId vendedorId:String,Texto texto:String){
         self.id = id
         self.data = data
         self.vendedorId = vendedorId
         self.texto = texto
    }
    
}
