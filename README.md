# PhillipRecruitment

library yang digunakan:
- Snapkit
- RxSwift
- RxCocoa

File-file yang dibuat:
1. MainViewController
Tampilan utama berupa UITableViewController untuk menampilkan daftar stock. Berfungsi juga menambahakn data stock secara acak tiap 0.3 detik. Terdapat pula tombol untuk pergi ke halaman ChooseViewController

2. ChooseViewController:
Halaman untuk memilih filter stock dengan komponen2:
- chosenLabel: label menyimpan daftar filter stock yang dipilih
- addButton: untuk menampilkan picker untuk memilih stock. Posisi addButton selalu di sebelah kanan chosenLabel. Jika stock dipilih, chosenLabel terupdate dan posisi addButton bergeser.
- applyButton: menetapkan filter berdasarkan daftar filter yang dipilih picker.

3. Trade
objek yang memuat data yang ditampilkan. Satu objek berarti satu baris pada tableview.

4. TradeCell
custom cell untuk tableView. Terbuat dari stackview horizontal. Menerima satu buah objek Trade dan menentukan warna data yang ditampilkan berdasarkan value chg dari objek Trade. 

5. TradeCollection
Controller yang mengatur pemfilteran stock dan stock apa saja yang ditampilkan pada MainViewController. Komponen2:
- trades: observable berupa array objek Trade yang belum difilter
- filteredTrades: observable berupa array objek Trade yang sudah difilter
- filterParam: filter berupa daftar stock yang ingin ditampilkan, dipilih melalui halaman ChooseViewController.

Alur app:
- Pada viewDidLoad MainViewController, menciptakan objek Trade dengan stock, price, chg, dan vol random serta act dan tanggal hari ini.
- Objek Trade langsung diappend pada array trades di TradeCollection
- MainViewController menjalankan filter pada TradeCollection, untuk memfilter objek Trade apa saja yang mau dipindah ke array filteredTrades berdasarkan filterParam.
- MainViewController melakukan subscribe pada filteredTrades yang memerintahkan untuk tableView untuk reloadData sesuai data2 filteredTrades tiap kali filteredTrades terupdate. Dalam hal ini, filteredTrades pasti terupdate tiap kali terjadi append pada array trades.
- Proses di atas dilakukan tiap 0.3 detik
- Secara asynchronus, user dapat pergi ke halaman ChooseViewController untuk memilih filter stock yang berfungsi untuk mengupdate filterParam pada TradeCollection.
