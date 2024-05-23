//
//  Planet.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 2/9/24.
//

import SwiftUI
import SceneKit



struct PlanetView: View {
    
    var planet: Planet
    @State private var isPresented = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        if !(planet.name == "Earth") {
                            Text("First Human Visual Observation")
                                .font(Font.custom("SF Pro Rounded Medium", size: 15))
                                .foregroundColor(.secondary)
                        } else {
                            Text("Earth was perceived as a planet")
                                .font(Font.custom("SF Pro Rounded Medium", size: 15))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    HStack {
                        Text(planet.visual)
                            .font(Font.custom("SF Pro Rounded Medium", size: 15))
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    
                    Spacer(minLength: 20)
                    ZStack {
                        SceneKitView(planet: planet.name.lowercased(), stars: false)
                            .frame(height: 300)
                            .background(Color.black)
                            .cornerRadius(30)
                            .padding(8)
                        
                        
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.isPresented.toggle()
                                }) {
                                    HStack {
                                        Image(systemName: "arrow.down.left.and.arrow.up.right")
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                    .clipShape(RoundedRectangle(cornerRadius: 500))
                                    .padding(.top, 16)
                                    .padding([.trailing], 16)
                                }
                                .fullScreenCover(isPresented: $isPresented) {
                                    SomeView(planet: planet)
                                }
                            }
                            Spacer()
                        }
                        
                        VStack {
                            Spacer()
                            HStack {
                                Text(" SceneKit")
                                    .font(Font.custom("SF Pro Rounded Semibold", size: 18))
                                    .foregroundColor(.white)
                                    .padding([.bottom], 20)
                                    .padding([.leading], 24)
                                Spacer()
                            }
                        }
                        Spacer()
                    }
                }
                .padding()
                

                VStack(spacing: 16) {
                    
                    HStack {
                        PlanetPropertyView(title: "Natural Satellites", value: String(planet.moons), unit: "moons", color: planet.color)
                        PlanetPropertyView(title: "Planetary Rings", value: String(planet.rings), unit: "rings", color: planet.color)
                    }
                    
                    HStack {
                        PlanetPropertyView(title: "Gravity", value: String(planet.gravity), unit: "m/s²", color: planet.color)
                        PlanetPropertyView(title: "Escape Velocity", value: planet.escapeVelocity, unit: "km/h", color: planet.color)
                    }
                    
                    PlanetPropertyView(title: "Equatorial Radius", value: planet.radius, unit: "km", color: planet.color)
                    PlanetPropertyView(title: "Mass", value: planet.mass, unit: "kg", color: planet.color)
                    PlanetPropertyView(title: "Volume", value: planet.volume, unit: "km³", color: planet.color)
                    
                    HStack() {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Atmosphere")
                                .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                .foregroundColor(.secondary)
                            HStack(alignment: .firstTextBaseline) {
                                
                                ForEach(Array(planet.atmosphere.enumerated()), id: \.element) { index, image in
                                    Image(image)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(8)
                                }
                                
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    Divider()
                    ChartView(planet: planet)
                        .padding(.horizontal, 12)
                }
                .padding()
            }
            .navigationTitle(planet.name)
            .onAppear {
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
                ]
            }
            .navigationBarItems(
                trailing: ShareLink(item: URL(string: "https://apps.apple.com/app/cosmofy/id6450969556")!, preview: SharePreview("Cosmofy on the Apple App Store", image: Image("iconApp")))
                    .foregroundStyle(planet.color)
            )
        }
        .onAppear(perform: {Haptics.shared.vibrate(for: .success)})
    }
}

struct ImageName: Identifiable, Equatable {
    let id: UUID = .init()
    let value: String
}

struct ImagesView: View {
    @Namespace var namespace
    var planet: Planet
    
    
    @State private var selectedItem: ImageName?
    @State private var position = CGSize.zero
    
    var body: some View {
        let dataList = (1..<5).map { ImageName(value: "\(planet.name.lowercased())_image_\($0)") }
        ZStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2)
                ], spacing: 2) {
                    ForEach(dataList) { data in
                        Image(data.value)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(
                                id: data.id,
                                in: namespace,
                                isSource:  selectedItem == nil
                            )
                            .zIndex(selectedItem == data ? 1 : 0)
                            .onTapGesture {
                                position = .zero
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                    selectedItem = data
                                }
                            }
                    }
                }
                .padding(2)
            }
            
            Color.black
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .opacity(selectedItem == nil ? 0 : min(1, max(0, 1 - abs(Double(position.height) / 800))))
            
            if let selectedItem {
                Image(selectedItem.value)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(
                        id: selectedItem.id,
                        in: namespace,
                        isSource: self.selectedItem != nil
                    )
                    .zIndex(2)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                            self.selectedItem = nil
                        }
                    }
                    .offset(position)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.position = value.translation
                            }
                            .onEnded { value in
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                    if 200 < abs(self.position.height) {
                                        self.selectedItem = nil
                                    } else {
                                        self.position = .zero
                                    }
                                }
                            }
                    )
            }
        }
    }
}

struct SomeView: View {
    let backgroundGradient = LinearGradient(
        colors: [Color.cyan, Color.blue],
        startPoint: .top, endPoint: .bottom)
    var planet: Planet
    
    @Environment (\.presentationMode) var presentationMode
    @State private var selectedViewType: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                switch selectedViewType {
                    case 0:
                        SceneKitView(planet: planet.name.lowercased(), isFullScreen: true, stars: true)
                            .background(Color.black)
                            .cornerRadius(30)
                            .onAppear(perform: {
                                Haptics.shared.impact(for: .light)
                            })
                            .background(.black)

                    case 1:
                        ZStack {
                            Color.black
                            Text("To Be Added")
                                .foregroundStyle(.white)
                        }
                        .ignoresSafeArea(.all)
                        
                    /**
                    case 2:
                        ImagesView(planet: planet)
                            .padding(.top, 96)
                            .background(Color.black)
                    */

                    default:
                        Text("Selection not available")

                }
            }
            
            VStack {
                Picker("View Type", selection: $selectedViewType) {
                    Text("3D").tag(0)
                    Text("AR").tag(1)
                /**
                    Text("Images").tag(2)

                    Scene becomes laggy with warning:
                    SCNView implements focusItemsInRect: - caching for linear focus movement is limited as long as this view is on screen.
                    Will fix in v1.2
                 **/
                }
                .environment(\.colorScheme, .dark)
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top, 64)
                .padding(.horizontal, 96)
                Spacer()
            }

            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill") // The icon
                            .resizable()
                            .foregroundStyle(.white.opacity(0.7))
                            .frame(width: 30, height: 30)
                            .padding(.top, 64)
                            .padding(.trailing, 16)
                    }
                }
                Spacer()
            }
            
            
            
        }
        .ignoresSafeArea()

    }
    
}

struct SceneKitView: UIViewControllerRepresentable {
    var planet: String
    
    var width: CGFloat?
    var height: CGFloat?
    var isFullScreen: Bool = false
    var stars: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let sceneView = SCNView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(sceneView)
        
        if isFullScreen {
            NSLayoutConstraint.activate([
                sceneView.leftAnchor.constraint(equalTo: viewController.view.leftAnchor),
                sceneView.rightAnchor.constraint(equalTo: viewController.view.rightAnchor),
                sceneView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
                sceneView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                sceneView.widthAnchor.constraint(equalToConstant: width ?? 300),
                sceneView.heightAnchor.constraint(equalToConstant: height ?? 300),
                sceneView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
                sceneView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
            ])
        }
        
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.backgroundColor = UIColor.black
        
        
        let planetNode = PlanetNode(radius: 1.25, planet: planet, rotation: 10)
        planetNode.position = SCNVector3(0, 0, 0) // Center the node
        scene.rootNode.addChildNode(planetNode)
        
        if planet == "saturn" {
            let saturnLoop = SCNBox(width: 5.556, height: 0, length: 6.944, chamferRadius: 0)
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named:"map-saturn-ring")
            saturnLoop.materials = [material]
            let loopNode = SCNNode(geometry: saturnLoop)
//            loopNode.rotation = SCNVector4(-0.5,-0.5, 0, 5)
            loopNode.position = SCNVector3(x:0,y:0,z:0)
            planetNode.addChildNode(loopNode)
        }
        
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()

        if isFullScreen {
            if planet == "saturn" {
                cameraNode.position = SCNVector3(x: 0, y: 3, z: 10)
                cameraNode.eulerAngles = SCNVector3(x: -Float.pi / 10, y: 0, z: 0)
            } else {
                cameraNode.position = SCNVector3(x: 0, y: 0, z: 7)
            }
            
        } else {
            if planet == "saturn" {
                cameraNode.position = SCNVector3(x: 0, y: 2, z: 7)
                cameraNode.eulerAngles = SCNVector3(x: -Float.pi / 10, y: 0, z: 0)
            } else {
                cameraNode.position = SCNVector3(x: 0, y: 0, z: 3.5)
            }
        }

        if stars {
            let starsParticleSystem = SCNParticleSystem(named: "StarsParticleSystem.scnp", inDirectory: nil)!
            scene.rootNode.addChildNode(cameraNode)
            scene.rootNode.addParticleSystem(starsParticleSystem)
        }
        
        sceneView.pointOfView = cameraNode
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update the UI when state changes
    }
    
    typealias UIViewControllerType = UIViewController
}


#Preview {
    PlanetView(planet: saturnPlanet)
}


struct PlanetPropertyView: View {
    var title: String
    var value: String
    var unit: String
    var color: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(Font.custom("SF Pro Rounded Medium", size: 16))
                    .foregroundColor(.secondary)
                HStack(alignment: .firstTextBaseline) {
                    Text(value).font(Font.custom("SF Pro Rounded Semibold", size: 20))
                    Text(unit).font(Font.custom("SF Pro Rounded Semibold", size: 16)).foregroundStyle(color)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}
