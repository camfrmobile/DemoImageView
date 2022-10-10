//
//  ViewController.swift
//  DemoImageView
//
//  Created by Trần Văn Cam on 06/10/2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    
    // MARK: Timer
    // vòng lặp lại 1 công việc nhiều lần, có thời gian delay
    var abcTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadingActivity.style = .large
        loadingActivity.color = #colorLiteral(red: 0.9750413299, green: 0.3196246922, blue: 0.04297067225, alpha: 1)
        loadingActivity.isAnimating // kiểm tra xem có đang chạy hiệu ứng không
        loadingActivity.startAnimating() //
        loadingActivity.hidesWhenStopped = true // cho ẩn đi khi dừng
        
        // Hiển thị ảnh từ asset (local)
        
        contentImageView.image = UIImage(named: "TIT-991") // Truyền ảnh vào bằng tên ảnh (đã được thêm vào asset)
        
        contentImageView.contentMode = .scaleAspectFill // scale ảnh full cái khung imageView (giữ nguyên tỷ lệ ảnh)
        // .scaleToFill kéo giãn 2 chiều dài và rộng để full khung => ảnh bị kéo dãn => méo
        // .scaleAspectFit: Hiển thị đầy đủ ảnh trong view, không bị kéo giãn
        
        
        // HIển thị ảnh từ URL
        // B1: lấy được url trả về ảnh
        let url = URL(string: "https://khoinguonsangtao.vn/wp-content/uploads/2022/08/tai-background-dep-nhat.jpg")
        // B2: lấy dữ liệu từ url đó
        let data = try? Data(contentsOf: url!)
        
        
        do {
            // thử làm hành động không chắc chắn, nếu thành công sẽ làm tiếp câu lệnh tiếp theo, nếu thất bại, lỗi đc bắt ở catch, k thực hiện câu lệnh sau try
            let data = try Data(contentsOf: url!)
            contentImageView.image = UIImage(data: data)
            
            loadingActivity.stopAnimating()
        } catch let error {
            print("Something wrong \(error.localizedDescription)")
            loadingActivity.stopAnimating()
        }
        
        
        // convert từ data về UIImage sau đó gán vào ImageView
        contentImageView.image = UIImage(data: data!)
        
        // ProgressView: Thể hiện tiến độ hoàn thành của 1 công việc nào đó
        progressView.progress = 0 // Tiến độ công việc chạy từ 0 - 1
        progressView.progressTintColor = .cyan // Màu của phần tiến độ đã hoàn thành
        progressView.trackTintColor = .red // Màu của phần chưa hoàn thành
        
        setupTimer()
    }

    func setupTimer() {
        // timeInterval: thời gian delay để lặp lại khối lệnh
        // Repeat: có lặp lại hay không
        // Block: Khối lệnh cần thực hiện
        abcTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            self.progressView.progress += 0.1
            
            print(self.abcTimer.isValid) // kiểm tra timer có còn hoạt động hay k
            
            if self.progressView.progress >= 1 {
                self.abcTimer.invalidate()
                self.loadingActivity.stopAnimating()
            }
            print(self.progressView.progress)
            
        })
    }
}

