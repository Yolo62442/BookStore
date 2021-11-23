//
//  ReviewViewController.swift
//  ShopApp
//
//  Created by Zhansaya on 15.06.2021.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var inputTextField: UITextField!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var containerViewHeightConstraint: NSLayoutConstraint!
    private var presenter: ReviewPresenter!
    
    public var ISBN: Int? /*{
        didSet{
            if let ISBN = ISBN{
                self.presenter = ReviewPresenter(self, isbn: ISBN)
            }
        }
    }*/
    
    private var reviews: [ReviewEntity] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextField.delegate = self
        let tapOnTableView = UITapGestureRecognizer(target: self, action: #selector(tappedOnTableView))
        tableView.addGestureRecognizer(tapOnTableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: ReviewCell.identifier, bundle: Bundle(for: ReviewCell.self)), forCellReuseIdentifier: ReviewCell.identifier)
        self.presenter = ReviewPresenter(self, isbn: ISBN ?? 0)
    }
    
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        guard let review = inputTextField.text else {return }
        presenter.sendReviewsToFirebase(review, ISBN ?? 0)
        sendButton.isEnabled = false
        inputTextField.text = ""
    }
}

//MARK: - internal function
extension ReviewViewController{
    @objc private func tappedOnTableView(){
        inputTextField.endEditing(true)
    }
    
    private func scrollToLastReview(){
        if reviews.count - 1 > 0 {
            let indexpath = IndexPath(row: reviews.count - 1, section: 0)
            tableView.scrollToRow(at: indexpath, at: .bottom, animated: true)
        }
        
    }
   
}
//MARK: - UITextFieldDelegate
extension ReviewViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2){
            self.containerViewHeightConstraint.constant = 50 + 250 // IPHONE X, 11, 12 == 310, 300
            self.view.layoutIfNeeded()
        }
        scrollToLastReview()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2){
            self.containerViewHeightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
        scrollToLastReview()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ReviewViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as! ReviewCell
        let review = reviews[indexPath.row]
        cell.review = review
        return cell
    }
}

extension ReviewViewController: ReviewPresenterDelegate{
    func fetchReviewsFromFirebase(_ reviews: [ReviewEntity]) {
        self.reviews = reviews
        self.tableView.reloadData()
        self.scrollToLastReview()
    }
    
    func sendReviewToFirebase() {
        self.sendButton.isEnabled = true
    }
    
    
}
