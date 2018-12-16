//
//  DetailViewController.swift
//  boostcamp_3_iOS
//
//  Created by 김예은 on 10/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sView1: UIView!
    @IBOutlet weak var sView2: UIView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var pdLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var id: String?
    var comments: [Comment] = [Comment]()
    
    var isDetail = false
    var isComment = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        loader.startAnimating()
        loader.hidesWhenStopped = true
        
        backView.circleImageView()
        sView1.layer.addBorder(edge: .right, color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), thickness: 0.5)
        sView2.layer.addBorder(edge: .right, color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), thickness: 0.5)
        
        getDetailInit(_id: id ?? "")
        getCommentList(_id: id ?? "")
        
    }
    
    func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setLoder() {
        loader.startAnimating()
        loader.hidesWhenStopped = true
        
        if isComment == true && isDetail == true {
            DispatchQueue.main.async {
                self.loader.stopAnimating()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sizeHeaderToFit()
    }

    func sizeHeaderToFit() {
        if let headerView = tableView.tableHeaderView {
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()

            let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            var frame = headerView.frame
            frame.size.height = height
            headerView.frame = frame

            tableView.tableHeaderView = headerView
        }
    }
    
    
    
    func getStar(rate: Double) {

        if rate == 0.0 {
            star1.image = #imageLiteral(resourceName: "emptyStar")
            star2.image = #imageLiteral(resourceName: "emptyStar")
            star3.image = #imageLiteral(resourceName: "emptyStar")
            star4.image = #imageLiteral(resourceName: "emptyStar")
            star5.image = #imageLiteral(resourceName: "emptyStar")
        } else if rate > 0.0 && rate <= 1.25 {
            star1.image = #imageLiteral(resourceName: "fullStar")
            star2.image = #imageLiteral(resourceName: "emptyStar")
            star3.image = #imageLiteral(resourceName: "emptyStar")
            star4.image = #imageLiteral(resourceName: "emptyStar")
            star5.image = #imageLiteral(resourceName: "emptyStar")
        } else if rate > 1.25 && rate <= 2.5  {
            star1.image = #imageLiteral(resourceName: "fullStar")
            star2.image = #imageLiteral(resourceName: "halfStar")
            star3.image = #imageLiteral(resourceName: "emptyStar")
            star4.image = #imageLiteral(resourceName: "emptyStar")
            star5.image = #imageLiteral(resourceName: "emptyStar")
            
        } else if rate > 2.5 && rate <= 3.75  {
            star1.image = #imageLiteral(resourceName: "fullStar")
            star2.image = #imageLiteral(resourceName: "fullStar")
            star3.image = #imageLiteral(resourceName: "emptyStar")
            star4.image = #imageLiteral(resourceName: "emptyStar")
            star5.image = #imageLiteral(resourceName: "emptyStar")
            
        } else if rate > 3.75 && rate <= 5.0  {
            star1.image = #imageLiteral(resourceName: "fullStar")
            star2.image = #imageLiteral(resourceName: "fullStar")
            star3.image = #imageLiteral(resourceName: "halfStar")
            star4.image = #imageLiteral(resourceName: "emptyStar")
            star5.image = #imageLiteral(resourceName: "emptyStar")
            
        } else if rate > 5.0 && rate <= 6.25 {
            star1.image = #imageLiteral(resourceName: "fullStar")
            star2.image = #imageLiteral(resourceName: "fullStar")
            star3.image = #imageLiteral(resourceName: "fullStar")
            star4.image = #imageLiteral(resourceName: "emptyStar")
            star5.image = #imageLiteral(resourceName: "emptyStar")
        } else if rate > 6.25 && rate <= 7.5 {
            star1.image = #imageLiteral(resourceName: "fullStar")
            star2.image = #imageLiteral(resourceName: "fullStar")
            star3.image = #imageLiteral(resourceName: "fullStar")
            star4.image = #imageLiteral(resourceName: "halfStar")
            star5.image = #imageLiteral(resourceName: "emptyStar")
        } else if rate > 7.5 && rate <= 8.75{
            star1.image = #imageLiteral(resourceName: "fullStar")
            star2.image = #imageLiteral(resourceName: "fullStar")
            star3.image = #imageLiteral(resourceName: "fullStar")
            star4.image = #imageLiteral(resourceName: "fullStar")
            star5.image = #imageLiteral(resourceName: "emptyStar")
        } else   {
            star1.image = #imageLiteral(resourceName: "fullStar")
            star2.image = #imageLiteral(resourceName: "fullStar")
            star3.image = #imageLiteral(resourceName: "fullStar")
            star4.image = #imageLiteral(resourceName: "fullStar")
            star5.image = #imageLiteral(resourceName: "fullStar")
        }
    }
}

//MARK: 서버 통신
extension DetailViewController {
    
    //MARK: GET - 영화 상세정보
    func getDetailInit(_id: String) {

        DetailMovieService.getDetailMovie(id: _id) {
            (details) in
            
            self.isDetail = true
            DispatchQueue.main.async {
                
                if self.isComment == true && self.isDetail == true {
                    DispatchQueue.main.async {
                        self.loader.stopAnimating()
                    }
                }
                
                let age = details.grade
                
                if age == 12 {
                    self.backView.backgroundColor = #colorLiteral(red: 0.1530615985, green: 0.6496087909, blue: 0.9544004798, alpha: 1)
                } else if age == 15 {
                    self.backView.backgroundColor = #colorLiteral(red: 0.9925124049, green: 0.5890587568, blue: 0.1203630492, alpha: 1)
                } else if age == 19 {
                    self.backView.backgroundColor = #colorLiteral(red: 0.9108503461, green: 0.2307577431, blue: 0.2491486371, alpha: 1)
                } else {
                    self.backView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                }
                
                if age == 0 {
                    self.ageLabel.text = "전체"
                } else {
                    self.ageLabel.text = details.grade.description
                }
                
                self.navigationItem.title = details.title
                self.titleLabel.text = details.title
                self.dateLabel.text = details.date
                self.genreLabel.text = details.genre
                self.timeLabel.text = details.duration.description
                
                self.rankLabel.text = details.reservation_grade.description
                self.percentLabel.text = details.reservation_rate.description
                self.rateLabel.text = details.user_rating.description
                self.peopleLabel.text = details.audience.description
                
                self.contentTextView.text = details.synopsis
                self.pdLabel.text = details.director
                self.actorLabel.text = details.actor
                
                self.getStar(rate: details.user_rating)
                    
            }
            
            ImageService.getImageUpload(imageUrl: details.image) {
                (image) in
                
                DispatchQueue.main.async(execute: {
                    self.movieImageView.image = image
                })
            }
            
        }
    }
    
    //MARK: GET - 영화 한줄평
    func getCommentList(_id: String) {

        CommentService.getCommentList(id: _id) {
            
            (commentData) in
            
            self.isComment = true
            self.comments = commentData
            
            DispatchQueue.main.async(execute: {
                
                if self.isComment == true && self.isDetail == true {
                    DispatchQueue.main.async {
                        self.loader.stopAnimating()
                    }
                }
                
                self.tableView.reloadData()
            })
            
        }
    }
    
    
}

//MARK: TableView Extension
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseIdentifier, for: indexPath) as! ReviewTableViewCell
        
        cell.nameLabel.text = comments[indexPath.row].writer
        cell.dateLabel.text = comments[indexPath.row].timestamp.description
        cell.reviewLabel.text = comments[indexPath.row].contents
        
        let rate = comments[indexPath.row].rating
        
        if rate == 0.0 {
            cell.star1.image = #imageLiteral(resourceName: "emptyStar")
            cell.star2.image = #imageLiteral(resourceName: "emptyStar")
            cell.star3.image = #imageLiteral(resourceName: "emptyStar")
            cell.star4.image = #imageLiteral(resourceName: "emptyStar")
            cell.star5.image = #imageLiteral(resourceName: "emptyStar")
        } else if rate > 0.0 && rate <= 1.25 {
            cell.star1.image = #imageLiteral(resourceName: "fullStar")
            cell.star2.image = #imageLiteral(resourceName: "emptyStar")
            cell.star3.image = #imageLiteral(resourceName: "emptyStar")
            cell.star4.image = #imageLiteral(resourceName: "emptyStar")
            cell.star5.image = #imageLiteral(resourceName: "emptyStar")
        } else if rate > 1.25 && rate <= 2.5  {
            cell.star1.image = #imageLiteral(resourceName: "fullStar")
            cell.star2.image = #imageLiteral(resourceName: "halfStar")
            cell.star3.image = #imageLiteral(resourceName: "emptyStar")
            cell.star4.image = #imageLiteral(resourceName: "emptyStar")
            cell.star5.image = #imageLiteral(resourceName: "emptyStar")
            
        } else if rate > 2.5 && rate <= 3.75  {
            cell.star1.image = #imageLiteral(resourceName: "fullStar")
            cell.star2.image = #imageLiteral(resourceName: "fullStar")
            cell.star3.image = #imageLiteral(resourceName: "emptyStar")
            cell.star4.image = #imageLiteral(resourceName: "emptyStar")
            cell.star5.image = #imageLiteral(resourceName: "emptyStar")
            
        } else if rate > 3.75 && rate <= 5.0  {
            cell.star1.image = #imageLiteral(resourceName: "fullStar")
            cell.star2.image = #imageLiteral(resourceName: "fullStar")
            cell.star3.image = #imageLiteral(resourceName: "halfStar")
            cell.star4.image = #imageLiteral(resourceName: "emptyStar")
            cell.star5.image = #imageLiteral(resourceName: "emptyStar")
            
        } else if rate > 5.0 && rate <= 6.25 {
            cell.star1.image = #imageLiteral(resourceName: "fullStar")
            cell.star2.image = #imageLiteral(resourceName: "fullStar")
            cell.star3.image = #imageLiteral(resourceName: "fullStar")
            cell.star4.image = #imageLiteral(resourceName: "emptyStar")
            cell.star5.image = #imageLiteral(resourceName: "emptyStar")
        } else if rate > 6.25 && rate <= 7.5 {
            cell.star1.image = #imageLiteral(resourceName: "fullStar")
            cell.star2.image = #imageLiteral(resourceName: "fullStar")
            cell.star3.image = #imageLiteral(resourceName: "fullStar")
            cell.star4.image = #imageLiteral(resourceName: "halfStar")
            cell.star5.image = #imageLiteral(resourceName: "emptyStar")
        } else if rate > 7.5 && rate <= 8.75{
            cell.star1.image = #imageLiteral(resourceName: "fullStar")
            cell.star2.image = #imageLiteral(resourceName: "fullStar")
            cell.star3.image = #imageLiteral(resourceName: "fullStar")
            cell.star4.image = #imageLiteral(resourceName: "fullStar")
            cell.star5.image = #imageLiteral(resourceName: "emptyStar")
        } else   {
            cell.star1.image = #imageLiteral(resourceName: "fullStar")
            cell.star2.image = #imageLiteral(resourceName: "fullStar")
            cell.star3.image = #imageLiteral(resourceName: "fullStar")
            cell.star4.image = #imageLiteral(resourceName: "fullStar")
            cell.star5.image = #imageLiteral(resourceName: "fullStar")
        }
        
        return cell
    }
    
    
}
