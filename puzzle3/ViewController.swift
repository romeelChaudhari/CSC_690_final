//
//  ViewController.swift
//  PuzzleR
//
//  Created by Romeel Chaudhari on 11/15/19.
//  Copyright © 2019 Romeel Chaudhari. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    
    let questionIArray = [#imageLiteral(resourceName: "Layer 1"), #imageLiteral(resourceName: "Layer 3"), #imageLiteral(resourceName: "Layer 6"), #imageLiteral(resourceName: "Layer 4"), #imageLiteral(resourceName: "Layer 5"), #imageLiteral(resourceName: "Layer 7"), #imageLiteral(resourceName: "Layer 8"), #imageLiteral(resourceName: "Layer 10"), #imageLiteral(resourceName: "Layer 9")]
    let cAns = [0,3,1,4,2,5,6,8,7]
    var wAns = Array(0..<9)
    var wrongImageArray=[UIImage]()
    var undoMArray = [(first: IndexPath, second: IndexPath)]()
    var noMoves = 0
    
    var firstIPath: IndexPath?
    var secondIPath: IndexPath?        //Each index in an index path represents the index into an array of children from one node in the tree to another, deeper, node.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PuzzleR"
        self.navigationController?.navigationBar.isTranslucent = false
        
        wrongImageArray = questionIArray
        setupViews()
    }
    
    @objc func btnSwapAction() {
        guard let start = firstIPath, let end = secondIPath else { return }
        myCollectionView.performBatchUpdates({
            myCollectionView.moveItem(at: start, to: end)
            myCollectionView.moveItem(at: end, to: start)
        }) { (finished) in
            self.myCollectionView.deselectItem(at: start, animated: true)
            self.myCollectionView.deselectItem(at: end, animated: true)
            self.firstIPath = nil
            self.secondIPath = nil
            self.wrongImageArray.swapAt(start.item, end.item)
            self.wAns.swapAt(start.item, end.item)
            self.undoMArray.append((first: start, second: end))
            self.noMoves += 1
            self.lblMoves.text = "Moves: \(self.noMoves)"
            if self.wAns == self.cAns {
                let alert=UIAlertController(title: "You Won!", message: "Congratulations 👍", preferredStyle: .alert)
                let Quit = UIAlertAction(title: "Quit", style: .default, handler: { (action) in
                    self.quit()})
                let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (action) in
                    self.restartGame()
                })
                alert.addAction(Quit)
                alert.addAction(restartAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func quit()
    {
        exit(0)
        
        }
    func restartGame() {
        self.undoMArray.removeAll()
        wAns = Array(0..<9)
        wrongImageArray = questionIArray
        firstIPath = nil
        secondIPath = nil
        self.noMoves = 0
        self.lblMoves.text = "Moves: \(noMoves)"
        self.myCollectionView.reloadData()
    }
    
    @objc func btnUndoAction() {
        if undoMArray.count == 0 {
            return
        }
        let start = undoMArray.last!.first
        let end = undoMArray.last!.second
        myCollectionView.performBatchUpdates({
            myCollectionView.moveItem(at: start, to: end)
            myCollectionView.moveItem(at: end, to: start)
        }) { (finished) in
            // update data source here
            self.wrongImageArray.swapAt(start.item, end.item)
            self.wAns.swapAt(start.item, end.item)
            self.undoMArray.removeLast()
            self.noMoves += 1
            self.lblMoves.text = "Moves: \(self.noMoves)"
        }
    }
    @objc func closeApp()
    {
        exit(0)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageViewCVCell
        cell.imgV.image=wrongImageArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if firstIPath == nil {
            firstIPath = indexPath
            collectionView.selectItem(at: firstIPath, animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
        } else if secondIPath == nil {
            secondIPath = indexPath
            collectionView.selectItem(at: secondIPath, animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
        } else {
            collectionView.deselectItem(at: secondIPath!, animated: true)
            secondIPath = indexPath
            collectionView.selectItem(at: secondIPath, animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath == firstIPath {
            firstIPath = nil
        } else if indexPath == secondIPath {
            secondIPath = nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width/3, height: width/3)
    }
    
    func setupViews() {
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(ImageViewCVCell.self, forCellWithReuseIdentifier: "Cell")
        
        self.view.addSubview(myCollectionView)
        myCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive=true
        myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive=true
        myCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -21).isActive=true
        myCollectionView.heightAnchor.constraint(equalTo: myCollectionView.widthAnchor).isActive=true
        
        self.view.addSubview(btnSwap)
        btnSwap.widthAnchor.constraint(equalToConstant: 200).isActive=true
        btnSwap.topAnchor.constraint(equalTo: myCollectionView.bottomAnchor, constant: 20).isActive=true
        btnSwap.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        btnSwap.heightAnchor.constraint(equalToConstant: 50).isActive=true
        btnSwap.addTarget(self, action: #selector(btnSwapAction), for: .touchUpInside)
        
        self.view.addSubview(btnUndo)
        btnUndo.widthAnchor.constraint(equalToConstant: 200).isActive=true
        btnUndo.topAnchor.constraint(equalTo: btnSwap.bottomAnchor, constant: 30).isActive=true
        btnUndo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        btnUndo.heightAnchor.constraint(equalToConstant: 50).isActive=true
        btnUndo.addTarget(self, action: #selector(btnUndoAction), for: .touchUpInside)
        
        self.view.addSubview(lblMoves)
        lblMoves.widthAnchor.constraint(equalToConstant: 200).isActive=true
        lblMoves.topAnchor.constraint(equalTo: btnUndo.bottomAnchor, constant: 20).isActive=true
        lblMoves.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        lblMoves.heightAnchor.constraint(equalToConstant: 50).isActive=true
        lblMoves.text = "Moves: \(noMoves)"
        
        self.view.addSubview(close)
        close.widthAnchor.constraint(equalToConstant: 200).isActive=true
        close.topAnchor.constraint(equalTo: btnUndo.bottomAnchor, constant: 170).isActive=true
        close.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        close.heightAnchor.constraint(equalToConstant: 50).isActive=true
         close.addTarget(self, action: #selector(closeApp), for: .touchUpInside)
    }
    
    let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing=0
        layout.minimumLineSpacing=0
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.allowsMultipleSelection = true
        cv.translatesAutoresizingMaskIntoConstraints=false
        return cv
    }()
    
    let btnSwap: UIButton = {
        let btn=UIButton(type: .system)
        btn.setTitle("Swap", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
         btn.setTitleColor(UIColor.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    let btnUndo: UIButton = {
        let btn=UIButton(type: .system)
        btn.setTitle("Undo", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    let lblMoves: UILabel = {
        let lbl=UILabel()
        lbl.textColor=UIColor.white
        lbl.textAlignment = .center
        lbl.font = lbl.font.withSize(30)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let close: UIButton = {
        let btn=UIButton(type: .system)
        btn.setTitle("EXIT", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 60)
        btn.setTitleColor(UIColor.yellow, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
}


















