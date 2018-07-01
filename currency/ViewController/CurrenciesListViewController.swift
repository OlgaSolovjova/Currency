//
//  CurrenciesListViewController.swift
//  currency
//
//  Created by Ольга on 30.06.2018.
//  Copyright © 2018 SO. All rights reserved.
//

import UIKit

class CurrenciesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var downloadingFailLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var currenciesTableView: UITableView!
    
    private var currenciesList = [Currency]()

    private let headerHeight: CGFloat = 65
    private var isLoadFailLabelShown = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateCurrenciesList()

        Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(self.updateCurrenciesList), userInfo: nil, repeats: true)
    }

    // MARK: - Set Data
    
    @objc private func updateCurrenciesList() {
        self.displayCurrenciesList(false)

        CurrenciesController().loadCurrencies { result in
            if self.currenciesList.isEmpty && result.isEmpty {
                self.displayDownloadingFail()
                return
            }
            
            if !result.isEmpty { self.currenciesList = result }
            self.isLoadFailLabelShown = result.isEmpty
            self.currenciesTableView.reloadData()

            self.displayCurrenciesList(true)
        }
    }

    private func displayCurrenciesList(_ displayed: Bool) {
        self.downloadingFailLabel.isHidden = true
        self.currenciesTableView.isHidden = !displayed

        if displayed {
            self.activityIndicatorView.stopAnimating()
        } else {
            self.activityIndicatorView.startAnimating()
        }
    }

    private func displayDownloadingFail() {
        self.downloadingFailLabel.isHidden = false
        self.currenciesTableView.isHidden = true
        self.activityIndicatorView.stopAnimating()
    }

    //  MARK: - Action
    
    @IBAction func refreshCurrencies(_ sender: Any) {
        self.updateCurrenciesList()
    }

    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currenciesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CyrrencyCell", for: indexPath) as? CurrencyTableViewCell else { return UITableViewCell(style: .default, reuseIdentifier: "") }
        let currency = self.currenciesList[indexPath.row]

        cell.nameLabel.text = currency.name ?? ""
        cell.volumeLabel.text = "volume: " + String(currency.volume)
        cell.amountLabel.text = String(format: "%.2f", currency.amount)

        if indexPath.row == self.currenciesList.count - 1 {
            cell.separatorInset.left = tableView.frame.width
        }
        
        return cell
    }

    // MARK: Table View Delegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.isLoadFailLabelShown ? self.headerHeight : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard self.isLoadFailLabelShown else { return nil }
        return LoadFailHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: self.headerHeight))
    }
}
