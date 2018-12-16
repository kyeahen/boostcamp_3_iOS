//
//  CollectionListViewController.swift
//  boostcamp_3_iOS
//
//  Created by 김예은 on 06/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class CollectionListViewController: UIViewController {

    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var actLoader: UIActivityIndicatorView!
    
    var movies: [Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        actLoader.startAnimating()
        actLoader.hidesWhenStopped = true
        getBoardList(_orderType: 0)
    }
    
    func setCollectionView() {
        self.listCollectionView.delegate = self
        self.listCollectionView.dataSource = self
    }
    
    @IBAction func listAction(_ sender: UIBarButtonItem) {
        
        listActionSheet {
            (orderType) in
            
            if orderType == 0 {
                self.getBoardList(_orderType: 0)
                self.navigationItem.title = "예매율순"
            } else if orderType == 1 {
                self.getBoardList(_orderType: 1)
                self.navigationItem.title = "큐레이션순"
            } else{
                self.getBoardList(_orderType: 2)
                self.navigationItem.title = "개봉일순"
            }
        }
    }
    

}

//MARK: 서버 통신
extension CollectionListViewController {
    
    func getBoardList(_orderType: Int) {
        MovieService.getMovieList(orderType: _orderType) {
            (movieData) in
            self.movies = movieData
            
            DispatchQueue.main.async(execute: {
                self.actLoader.stopAnimating()
                self.listCollectionView.reloadData()
            })
        }
    }
}


//MARK: CollectionView Extension
extension CollectionListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseIdentifier, for: indexPath) as! ListCollectionViewCell
        
        let age = movies[indexPath.row].grade
        
        if age == 12 {
            cell.backView.backgroundColor = #colorLiteral(red: 0.1530615985, green: 0.6496087909, blue: 0.9544004798, alpha: 1)
        } else if age == 15 {
            cell.backView.backgroundColor = #colorLiteral(red: 0.9925124049, green: 0.5890587568, blue: 0.1203630492, alpha: 1)
        } else if age == 19 {
            cell.backView.backgroundColor = #colorLiteral(red: 0.9108503461, green: 0.2307577431, blue: 0.2491486371, alpha: 1)
        } else {
            cell.backView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
        
        if age == 0 {
            cell.ageLabel.text = "전체"
        } else {
            cell.ageLabel.text = movies[indexPath.row].grade.description
        }
        
        cell.titleLabel.text = movies[indexPath.row].title
        cell.rankLabel.text = movies[indexPath.row].reservation_grade.description
        cell.rateLabel.text = movies[indexPath.row].user_rating.description
        cell.percentLabel.text = movies[indexPath.row].reservation_rate.description
        cell.dateLabel.text = movies[indexPath.row].date
        
        ImageService.getImageUpload(imageUrl: movies[indexPath.row].thumb) {
            (image) in
            
            DispatchQueue.main.async(execute: {
                cell.movieImageView.image = image
            })
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailViewController.reuseIdentifier) as! DetailViewController
        
        detailVC.id = movies[indexPath.row].id
    
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

