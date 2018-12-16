//
//  ExtensionControl.swift
//  boostcamp_3_iOS
//
//  Created by 김예은 on 06/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    
    //스토리보드 idetifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    //커스텀 백버튼 설정
    func setBackBtn(color : UIColor){
        
        let backBTN = UIBarButtonItem(image: UIImage(named: "icBackBtn"), //백버튼 이미지 파일 이름에 맞게 변경해주세요.
            style: .plain,
            target: self,
            action: #selector(self.pop))
        navigationItem.leftBarButtonItem = backBTN
        navigationItem.leftBarButtonItem?.tintColor = color
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func listActionSheet(orderHandler : @escaping (_ orderType : Int) -> Void){
        
        let alert = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤방식으로 정렬할까요?", preferredStyle: .actionSheet)
        
        let rateList = UIAlertAction(title: "예매율", style: .default) { (re1) in
            orderHandler(0)
        }
        let curationList = UIAlertAction(title: "큐레이션", style: .default) { (re2) in
            orderHandler(1)
        }
        let dateList = UIAlertAction(title: "개봉일", style: .default) { (re3) in
            orderHandler(2)
        }
        let cancleAction = UIAlertAction(title: "취소",style: .cancel)
        
        alert.addAction(rateList)
        alert.addAction(curationList)
        alert.addAction(dateList)
        alert.addAction(cancleAction)
        present(alert, animated: true)
    }
}

extension UIView {
    
    //이미지뷰 동그랗게 설정
    func circleImageView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
}

extension CALayer {
    
    //뷰 테두리 설정
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer();
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0, y:self.frame.height - thickness, width:self.frame.width, height:thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x:self.frame.width - thickness, y: 0, width: thickness, height:self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
}



