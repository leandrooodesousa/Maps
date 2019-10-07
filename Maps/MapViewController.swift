
//1-comecei add no storyboard o map kit view
//2-tem add o framework mapkit
//3-add o protocolo MKMapViewDelegate
//4-Outlet mapView
//5-Criei essa funcoes que sao autodocumentaveis
//6-add o framework CoreLocation, na aba Build Phases no incio onde coloca coloca se é para bloquear a rotacao ou não, e add no terceiro item chamado Link Binay
//7-coloquei o protocolo CLLocationManagerDelegate

//Mapa: conceito de latitude e longitude

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    //Serve para gerenciar a minha localização
    var delegationLocation = CLLocationManager()
    
    //coordenadas do locais
    //ex: base área de manaus
     let latitude: CLLocationDegrees = -3.141511
     let longitude: CLLocationDegrees = -59.992229
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        markerLocationMap(withTitle: "Base de área de Manaus", andSubTitle: "Base onde pousa os aviões militares de Manaus")
        
        //aqui digo que o responsavel por gerenciar o objeto delegationLocation será essa própria classe
        delegationLocation.delegate = self
        
        //precisao desejada da localizacao
        //desired = desejada
        //accuracy = precisao
        delegationLocation.desiredAccuracy = kCLLocationAccuracyBest
        
        //pedi a autorizacao do usuário para ficar verificando a todo momento a sua localizacao
        //tem que ir também no info para pedir permissão
        delegationLocation.requestWhenInUseAuthorization()
        
        //fica autualizando toda hora onde está a localização do usuário
        delegationLocation.startUpdatingLocation()
        
    }

    fileprivate func setupLocationMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> CLLocationCoordinate2D {
        
        //set as coordenadas em coordenada em 2d
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        //O delta é a diferenca de uma tela entre a horizontal e a vertical
        let deltaLatitude: CLLocationDegrees = 0.01
        let deltaLongitude: CLLocationDegrees = 0.01
        
        //area de visualizaçao das cooordenadas, o zoom do mapa
        let areaView: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: deltaLatitude, longitudeDelta: deltaLongitude)
        
        //indica a regiao que será localizada atraves da localizacao que por sua vez tem as coordenadas por meio da latitude e longitude
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: areaView)
        
        //coloca a localizacao em nosso mapa
        //começa aqui, vai puxando as outras informações
        mapView.setRegion(region, animated: true)
        
        return location
    }
    
    fileprivate func markerLocationMap(withTitle title: String,andSubTitle subtitle: String) {
        //marcado no mapa
        let annotation = MKPointAnnotation()
        
        //configurar
        annotation.coordinate = setupLocationMap(latitude: latitude, longitude: longitude)
        annotation.title = title
        annotation.subtitle = subtitle
        
        mapView.addAnnotation(annotation)
    }
    
}

