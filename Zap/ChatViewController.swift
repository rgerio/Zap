//
//  ChatViewController.swift
//  Zap
//
//  Created by Rogério Bezerra Santos on 27/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit
import FirebaseDatabase
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    var conversa_id: DatabaseReference!
    lazy var messageRef: DatabaseReference! = self.conversa_id.child("mensagens")
    var newMessageRefHandle: DatabaseHandle!
    var firebaseMessages = [Mensagens]()
    var messages = [JSQMessage]()
    
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    var vendorname: String!
    var lastSize = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        title = "Zap"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // messages from someone else
        addMessage(withId: "foo", name: "Mr.Bolt", text: "João, como está indo o chat?")
        // messages sent from local sender
        addMessage(withId: senderId, name: "Me", text: "Oi gente!")
        addMessage(withId: senderId, name: "Me", text: "Tá saindo!")
        // animates the receiving of a new message on the view
        finishReceivingMessage()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView?.textColor = UIColor.white
        } else {
            cell.textView?.textColor = UIColor.black
        }
        return cell
    }
    
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
    }
    
    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
        }
    }
    
    private func observeMessages() {

        newMessageRefHandle = self.messageRef.observe(.value, with: { (snapshot) -> Void in
            self.firebaseMessages = snapshot.value as! [Mensagens]
            var counter = 0
            for mensagem in self.firebaseMessages {
                if let id = mensagem.id as String!, let data = mensagem.data as String!, let vendedorId = mensagem.vendedorId as String!, let texto = mensagem.texto as String! {
                    counter += 1
                    if (counter > self.lastSize) {
                        self.lastSize += 1
                        if (vendedorId == self.senderId) {
                            self.addMessage(withId: id, name: self.vendorname, text: texto)
                        }
                        else {
                            self.addMessage(withId: id, name: self.senderDisplayName, text: texto)
                        }
                    }
                } else {
                    print("Erro! Mensagem em formato desconhecido!")
                }
            }
            self.finishReceivingMessage()
        })
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let itemRef = messageRef.childByAutoId() // 1
        let messageItem = [ // 2
            "senderId": senderId!,
            "senderName": senderDisplayName!,
            "text": text!,
            ]
        
        itemRef.setValue(messageItem) // 3
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
        
        finishSendingMessage() // 5
    }
    
}
