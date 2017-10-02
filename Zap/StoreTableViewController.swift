//
//  StoreTableViewController.swift
//  Zap
//
//  Created by Bruno Roberto Gouveia Carneiro da Cunha Filho on 22/09/17.
//  Copyright © 2017 Zap. All rights reserved.
//

import UIKit
import FirebaseDatabase

class StoreTableViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var dbref: DatabaseReference!
    
    var vendedor_id: DatabaseReference!
    var conversas = [DataSnapshot]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dbref = Database.database().reference()
        
        //debug
        self.defaults.set("-KvOzGzohDq3gaezDXJU", forKey: "Vendedor")
        
        //CARREGAMENTO DO VENDEDOR
        let savedVendedor = self.defaults.object(forKey: "Vendedor") as? String
        print("CARREGANDO VENDEDOR...")
        if savedVendedor != nil {
            print("VENDEDOR CARREGADO")
            vendedor_id = self.dbref.child("vendedores").child(savedVendedor!)
        } else {
            print("ERRO CRÍTICO: VENDEDOR NÃO FOI CARREGADO")
        }
        
        //CARREGAMENTO DAS CONVERSAS
        self.dbref.child("conversas").queryOrdered(byChild: "vendedoratual_id").queryEqual(toValue: self.vendedor_id.key).observe(.childAdded, with:  { (snapshot) -> Void in
            print("Há \(snapshot.childrenCount) conversas")
            
            self.conversas.append(snapshot)
            
            self.tableView.insertRows(at: [IndexPath(row: self.conversas.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
            
            /*self.conversasSnapshot = snapshot
            
            for snap in snapshot.children {
                let value = (snap as! DataSnapshot).value as? NSDictionary
                let produto_id = value?["produto_id"] as? String ?? ""
                print("Produto_ID: \(produto_id)")
            }
            
            self.tableView.reloadData()*/
        })
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.conversas.count //Int((self.conversasSnapshot ?? DataSnapshot()).childrenCount)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath) as! StoreTableViewCell

        
        let value = self.conversas[indexPath.row].value as? NSDictionary
        
        let conversa_id = value?["cliente_id"] as? String ?? ""
        self.dbref.child("clientes").child(conversa_id).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            cell.storeNameLabel.text = value?["nome"] as? String ?? ""
        })
        let produto_id = value?["produto_id"] as? String ?? ""
        self.dbref.child("produtos").child(produto_id).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            cell.storeLastTimeLabel.text = "Assunto: " + (value?["nome"] as? String ?? "")
            
            let url = URL(string: (value?["imagem"] as? String ?? ""))
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    cell.storeImage.contentMode = .scaleAspectFill
                    cell.storeImage.image = UIImage(data: data!)
                }
            }

        })
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        self.performSegue(withIdentifier: "chatSeller", sender: indexPath)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "chatSeller") {
            let vc = segue.destination as! ChatViewController
            let indexPath = sender as! NSIndexPath
            vc.conversa_id = self.conversas[indexPath.row].ref
            vc.senderId = "algum_vendedor_id"
            vc.senderDisplayName = "nome_do_vendedor"
            vc.vendorname = "algum_cliente_id"
        }
    }
    

}
