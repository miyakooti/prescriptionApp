//
//  SelectInterviewDateViewController.swift
//  PhotoApp
//
//  Created by arai kousuke on 2023/08/23.
//

import UIKit

final class SelectInterviewDateViewController: UIViewController {

//    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var submitButton: UIButton!
    var pageViews: [UITableView?] = []
    
    var selectedIndexPath: IndexPath?
    @IBOutlet weak var dateLabel: UILabel!
    

    
    private let reservations = [
        ReservationSlot(time: "9:05 ~ 9:10", isOpen: true),
        ReservationSlot(time: "9:15 ~ 9:20", isOpen: true),
        ReservationSlot(time: "9:30 ~ 9:35", isOpen: true),
        ReservationSlot(time: "9:45 ~ 9:50", isOpen: true),
        ReservationSlot(time: "10:05 ~ 10:10", isOpen: true),
        ReservationSlot(time: "10:15 ~ 10:20", isOpen: true),
        ReservationSlot(time: "10:30 ~ 10:35", isOpen: true),
        ReservationSlot(time: "10:45 ~ 10:50", isOpen: true),
        ReservationSlot(time: "11:05 ~ 11:10", isOpen: true),
        ReservationSlot(time: "11:15 ~ 11:20", isOpen: true),
        ReservationSlot(time: "11:30 ~ 11:35", isOpen: true),
        ReservationSlot(time: "11:45 ~ 11:50", isOpen: true),
        ReservationSlot(time: "12:05 ~ 12:10", isOpen: true),
        ReservationSlot(time: "12:15 ~ 12:20", isOpen: true),
        ReservationSlot(time: "12:30 ~ 12:35", isOpen: true),
        ReservationSlot(time: "12:45 ~ 12:50", isOpen: true),
        ReservationSlot(time: "13:05 ~ 13:10", isOpen: true),
        ReservationSlot(time: "13:15 ~ 13:20", isOpen: true),
        ReservationSlot(time: "13:30 ~ 13:35", isOpen: true),
        ReservationSlot(time: "13:45 ~ 13:50", isOpen: true),
        ReservationSlot(time: "14:05 ~ 14:10", isOpen: true),
        ReservationSlot(time: "14:15 ~ 14:20", isOpen: true),
        ReservationSlot(time: "14:30 ~ 14:35", isOpen: true),
        ReservationSlot(time: "14:45 ~ 14:50", isOpen: true),
        ReservationSlot(time: "15:05 ~ 15:10", isOpen: true),
        ReservationSlot(time: "15:15 ~ 15:20", isOpen: true),
        ReservationSlot(time: "15:30 ~ 15:35", isOpen: true),
        ReservationSlot(time: "15:45 ~ 15:50", isOpen: true),
        ReservationSlot(time: "16:05 ~ 16:10", isOpen: true),
        ReservationSlot(time: "16:15 ~ 16:20", isOpen: true),
        ReservationSlot(time: "16:30 ~ 16:35", isOpen: true),
        ReservationSlot(time: "16:45 ~ 16:50", isOpen: true),
        ReservationSlot(time: "17:05 ~ 17:10", isOpen: true),
        ReservationSlot(time: "17:15 ~ 17:20", isOpen: true),
        ReservationSlot(time: "17:30 ~ 17:35", isOpen: true),
        ReservationSlot(time: "17:45 ~ 17:50", isOpen: true),
    ]
    
    private let dates = [
        "2023/08/25",
        "2023/08/26",
        "2023/08/27",
        "2023/08/28",
        "2023/08/29",
        "2023/08/30",
        "2023/08/31",
        "2023/09/01",
        "2023/09/02",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        // ここでページの数を設定する
        let pageCount = dates.count
        
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageCount), height: pagesScrollViewSize.height)
        
        loadVisiblePages()
        
        submitButton.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    func loadPage(_ page: Int) {
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
    
    func loadVisiblePages() {
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        
        loadPage(currentPage)
        loadPage(currentPage + 1)
        loadPage(currentPage - 1)
        
        dateLabel.text = dates[currentPage]
    }
    

}


extension SelectInterviewDateViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadVisiblePages()
    }
}


    




extension SelectInterviewDateViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        false //ハイライトしない
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PickDateTableViewCell.className, for: indexPath) as! PickDateTableViewCell
        
        cell.selectionStyle = .none
        
        cell.dateLabel.text = reservations[indexPath.row].time
        
        if !reservations[indexPath.row].isOpen {
//            あいてないのでセルを無効化
        }
        
        if indexPath == selectedIndexPath {
            cell.checkImage.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            cell.checkImage.image = UIImage(systemName: "circle")
        }
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? PickDateTableViewCell else { return }
        selectedIndexPath = indexPath
        submitButton.isEnabled = true

        tableView.reloadData()
    }
    
}
