//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import FinniversKit
import MapKit

public class SearchResultMapViewDemoViewController: DemoViewController<UIView> {

    private let demoAnnotations: [SearchResultMapViewDemoAnnotation] = {
        return (0..<5).map { index in
            let isCluster = index % 2 == 0
            return SearchResultMapViewDemoAnnotation(
                coordinate: CLLocationCoordinate2D(latitude: 59.9458, longitude: 10.7800 + (0.005 * Double(index))),
                image: UIImage(named: isCluster ? .favouriteAdded : .rated),
                isCluster: isCluster
            )
        }
    }()

    private lazy var demoTileOverlay: MKTileOverlay = {
        let tile = MKTileOverlay(urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png")
        tile.canReplaceMapContent = true
        return tile

    }()

    private let defaultRegion = MKCoordinateRegion.init(
        center: CLLocationCoordinate2D.init(latitude: 66.149068058495473, longitude: 17.653576306638673),
        span: MKCoordinateSpan.init(latitudeDelta: 19.853012316209828, longitudeDelta: 28.124998591005721)
    )

    private lazy var searchResultMapView: SearchResultMapView = {
        let view = SearchResultMapView(withAutoLayout: true)
        view.delegate = self
        return view
    }()

    private var didSetupView = false

    // MARK: - Setup

    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .milk
        view.addSubview(searchResultMapView)

        let location = CLLocationCoordinate2D(latitude: 59.9458, longitude: 10.7800)
        searchResultMapView.configure(withDefaultRegion: defaultRegion)
        searchResultMapView.setMapOverlay(demoTileOverlay)
        searchResultMapView.centerMap(location: location, regionDistance: 1000, animated: true)
        demoAnnotations.forEach { searchResultMapView.addAnnotation($0) }

        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                searchResultMapView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
                view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: searchResultMapView.bottomAnchor, multiplier: 1.0),
                searchResultMapView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                searchResultMapView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
                ])
        }
    }

    // MARK: - Private

    private func addMapOverlay() {
        searchResultMapView.setMapOverlay(demoTileOverlay)
    }

    private func clearMapOverlay() {
        searchResultMapView.clearMapOverlay(demoTileOverlay)
    }

}

// MARK: - SearchResultMapViewDelegate

extension SearchResultMapViewDemoViewController: SearchResultMapViewDelegate {

    public func searchResultMapViewDidSelectChangeMapTypeButton(_ view: SearchResultMapView) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cancel = UIAlertAction(title: "Avbryt", style: .cancel, handler: nil)
        let demoOverlayAction = UIAlertAction(title: "Kart fra OSM", style: .default) { _ in
            self.addMapOverlay()
        }
        let defaultMapAction = UIAlertAction(title: "Standard kart", style: .default) { _ in
            self.clearMapOverlay()
        }

        alert.addAction(cancel)
        alert.addAction(demoOverlayAction)
        alert.addAction(defaultMapAction)

        present(alert, animated: true, completion: nil)
    }

    public func searchResultMapViewWillRenderAnnotation(_ view: SearchResultMapView, annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }

    public func searchResultMapViewDidSelectAnnotationView(_ view: SearchResultMapView, annotationView: MKAnnotationView) {
        if (annotationView.annotation as? SearchResultMapViewDemoAnnotation) != nil {
            print("Did press annotation")
        }
    }

    public func searchResultMapViewRegionWillChangeDueToUserInteraction(_ view: SearchResultMapView) {

    }

    public func searchResultMapViewRegionDidChange(_ view: SearchResultMapView) {

    }

    public func searchResultMapViewDidUpdateUserLocation(_ view: SearchResultMapView, userLocation: MKUserLocation) {

    }

}
