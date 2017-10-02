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
   // var imagem: UIImage
    
    init(Nome nome:String,LojaId lojaId:String,Descricao descricao:String ){
        self.codigo = ""
        self.lojaId = lojaId
        self.nome = nome
        self.descricao = descricao
       // self.imagem = imagem
    }
  
    func gerarCodigo() -> String {
        
        //let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let letters : NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< 4 {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}




