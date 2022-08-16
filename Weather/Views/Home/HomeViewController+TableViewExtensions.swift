//
//  HomeViewController+TableViewExtensions.swift
//  Weather
//
//  Created by Navi on 03/08/22.
//

// MARK: - TableView implementations
import UIKit

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cityVC = storyboard?.instantiateViewController(withIdentifier: "CityVC") as? CityViewController {
            let place = places[indexPath.row]
            cityVC.title = place.name
            cityVC.model = place
            navigationController?.pushViewController(cityVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            AnnotationManager.shared.removePin(at: indexPath.row, completion: { annotation in
                mapView.removeAnnotation(annotation)
            })
            places.remove(at: indexPath.row)
            _ = viewModel.updateBookmarks(with: places)
            tableView.endUpdates()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .blue
        cell.textLabel?.text = places[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0,
                                                        y: 0,
                                                        width: tableView.frame.width,
                                                        height: 50))
        headerView.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.frame = CGRect(x: 5,
                             y: 5,
                             width: headerView.frame.width-10,
                             height: headerView.frame.height-10)
        label.text = "Bookmarks"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
}
