//
//  RecipeHandle.swift
//  Recipt App
//
//  Created by Aamir Burma on 29/06/21.
//

import UIKit

class RecipeHandle: UIViewController {
    
    private var RecipeState = [Int]()
    
    private let myTableView = UITableView()
    
    private var RecipeArray = ["Pizza", "Pasta", "Brownbread", "Bhelpuri","Burger", "Momos", "Hotdog", "Noodles", "Sendwich"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Recipes Table View"
        
        view.addSubview(myTableView)
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myTableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
      }
}

extension RecipeHandle: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView(){
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(RecipeCell.self, forCellReuseIdentifier: "RecipeCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        RecipeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        
        cell.setupRecipeCellWith(title: RecipeArray[indexPath.row], index: indexPath.row, and: (RecipeState.contains(indexPath.row) ? true : false))
        cell.myButton.addTarget(self, action: #selector(openRecipeDetails), for: .touchUpInside)
        
        return cell
        
    }
    
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! RecipeCell
        if !RecipeState.contains(indexPath.row) {
            RecipeState.append(indexPath.row)
            cell.animateCell(at: indexPath.row)
            
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexpath: IndexPath)  {
        
            if  editingStyle == .delete {
                
                myTableView.beginUpdates()
                RecipeArray.remove(at: indexpath.row)
                myTableView.deleteRows(at: [indexpath], with: .fade)
                myTableView.endUpdates()
            }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexpath: IndexPath) -> CGFloat {
        
        100
    }
    
    @objc private func openRecipeDetails(_ sender:UIButton) {
        
        self.present(WebViewController(search: RecipeArray[sender.tag]), animated:true, completion:nil)
        navigationController?.pushViewController(WebViewController(search: RecipeArray[sender.tag]), animated: true)
        
    }
}
