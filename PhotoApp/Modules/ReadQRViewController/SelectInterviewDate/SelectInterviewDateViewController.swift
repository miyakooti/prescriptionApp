//
//  SelectInterviewDateViewController.swift
//  PhotoApp
//
//  Created by arai kousuke on 2023/08/23.
//

import UIKit
import SVProgressHUD

final class SelectInterviewDateViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var dateLabel: UILabel!

    private var pageViews: [UITableView?] = []
    private var selectedIndexPath: IndexPath?
    private var selectedTime = ""
    
    private let reservations = Constants.testReservationsData
    private let dates = Constants.testDates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        submitButton.addTarget(nil, action: #selector(showConfirmationAlert), for: .touchUpInside)
        setUpViews()

    }
    
    private func setUpViews() {
        
        scrollView.isPagingEnabled = true
        let pageCount = dates.count
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageCount), height: pagesScrollViewSize.height)
        loadVisiblePages()
        
        submitButton.isEnabled = false
        submitButton.backgroundColor = .lightGray
    }
    
    @objc
    private func showConfirmationAlert() {
        let pageWidth = scrollView.frame.size.width

        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        let alert = UIAlertController(title: "\(dates[currentPage]) \n\(selectedTime)", message: "この日程でよろしいですか？", preferredStyle: .alert)
        let ok = UIAlertAction(title: "はい", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
            
            self.processReservation()

        }
        let cancel = UIAlertAction(title: "いいえ", style: .cancel) { (acrion) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        alert.addAction(cancel)

        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func processReservation() {
        SVProgressHUD.show(withStatus: "予約処理中")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            SVProgressHUD.showSuccess(withStatus: "予約が確定しました。")

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                SVProgressHUD.dismiss()
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }

}


extension SelectInterviewDateViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadVisiblePages()
    }
    
    private func loadPage(_ page: Int) {
        if page < 0 || page >= pageViews.count {
            return
        }
        
        if pageViews[page] == nil {
            let tableView = UITableView(frame: CGRect(x: scrollView.frame.size.width * CGFloat(page), y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: PickDateTableViewCell.className, bundle: nil), forCellReuseIdentifier: PickDateTableViewCell.className)
            pageViews[page] = tableView
            scrollView.addSubview(tableView)
        }
    }
    
    private func loadVisiblePages() {
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        
        loadPage(currentPage)
        loadPage(currentPage + 1)
        loadPage(currentPage - 1)
        
        dateLabel.text = dates[currentPage]
    }
}



extension SelectInterviewDateViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? PickDateTableViewCell else { return }
        selectedIndexPath = indexPath
        submitButton.isEnabled = true
        submitButton.backgroundColor = .systemTeal
        
        tableView.reloadData()
    }
    
}


extension SelectInterviewDateViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PickDateTableViewCell.className, for: indexPath) as! PickDateTableViewCell
        
        cell.selectionStyle = .none
        cell.dateLabel.text = reservations[indexPath.row].time
        
        if indexPath == selectedIndexPath {
            cell.checkImage.image = UIImage(systemName: "checkmark.circle.fill")
            selectedTime = reservations[indexPath.row].time
        } else {
            cell.checkImage.image = UIImage(systemName: "circle")
        }
    
        return cell
    }
}
