//
//  TableListViewController.swift
//  boostcamp_3_iOS
//
//  Created by 김예은 on 06/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class TableListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var movies: [Movie] = [Movie]()
    var isCheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        loader.startAnimating()
        loader.hidesWhenStopped = true
        getBoardList(_orderType: 0)

    }
    
    func setTableView() {
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
    }
    
    func setLoader() {
        if isCheck == true {
            DispatchQueue.main.async {
                self.loader.stopAnimating()
            }
        }
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
extension TableListViewController {
    
    func getBoardList(_orderType: Int) {
        MovieService.getMovieList(orderType: _orderType) {
            (movieData) in
            
            self.movies = movieData
            
            DispatchQueue.main.async(execute: {
                self.loader.stopAnimating()
                self.listTableView.reloadData()
            })

        }
    }
}

//MARK: TableView Extension
extension TableListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as! ListTableViewCell
        
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
        cell.rateLabel.text = movies[indexPath.row].user_rating.description
        cell.rankLabel.text = movies[indexPath.row].reservation_grade.description
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailViewController.reuseIdentifier) as! DetailViewController
        
            detailVC.id = movies[indexPath.row].id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

}
