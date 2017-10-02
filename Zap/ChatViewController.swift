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
    //var firebaseMessages = [Dictionary<String, String>]()
    var messages = [JSQMessage]()
    
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    var vendorname: String!
    var vendorId: String!
    var lastId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        self.inputToolbar.contentView.leftBarButtonItem = nil
        title = "Zap"
        observeMessages()
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
        newMessageRefHandle = self.messageRef.observe(.childAdded, with: { (snapshot) -> Void in
            let receivedMessage = snapshot.value as! Dictionary<String, String>
            if let id = receivedMessage["id"] as String!, let sender_Id = receivedMessage["senderId"] as String!, let data = receivedMessage["data"] as String!, let vendedorId = receivedMessage["vendedor_id"] as String!, let texto = receivedMessage["texto"] as String! {
                self.lastId = Int(id)!
                //self.firebaseMessages.append(messageToAppend)
                if (sender_Id == self.senderId) {
                    self.addMessage(withId: self.senderId, name: self.senderDisplayName, text: texto)
                }
                else {
                    self.addMessage(withId: sender_Id, name: self.vendorname, text: texto)
                }
                self.finishReceivingMessage()
            } else {
                print("Erro! Mensagem em formato desconhecido!")
            }
        })
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let data = Date()
        let formato = DateFormatter()
        formato.dateFormat = "dd/MM/YYYY hh:mm"
        
        let messageToSend = [
            "id": "\(self.lastId + 1)",
            "senderId": self.senderId!,
            "data": formato.string(from: data),
            "vendedor_id": self.vendorId!,
            "texto": text!
        ]
        
        if (messageToSend["texto"]!.characters.count > 0) {
            //self.firebaseMessages.append(messageToSend)
            self.messageRef.child(messageToSend["id"]!).setValue(messageToSend)
            JSQSystemSoundPlayer.jsq_playMessageSentSound()
            self.finishSendingMessage()
        }
    }
    
}
