//
//  UserDetailView.swift
//  UserLibrary
//
//  Created by iOS Dev Ninja on 8/1/2025.
//

import MapKit
import SwiftUI

struct UserDetailView: View {
    let user: User
    
    @State private var isAnimated = false
    @State private var rotateAmount = 0.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack(alignment: .top) {
                    VStack(spacing: 10) {
                        UserInfoView(user: user)
                        MapView(user: user)
                    }
                    UserImageView(image: user.photoImage)
                }
            }
            .padding(.top, 120)
            .padding(.horizontal)
            .opacity(isAnimated ? 1.0 : 0.1)
            .rotation3DEffect(
                .degrees(rotateAmount),
                axis: (x:0, y:1, z:0)
            )
        }
        .background(.primary.opacity(0.1))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                isAnimated = true
                rotateAmount += 360
            }
        }
    }
}

struct UserImageView: View {
    let image: Image?
    
    var body: some View {
            image?
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(Circle().stroke(.white, lineWidth: 2))
            .shadow(radius: 3)
            .offset(y: -80)
    }
}

struct UserInfoView: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 50)
            
            VStack(spacing: 8) {
                Text(user.name)
                    .font(.title.bold())
            }
            .padding(.top, 40)
            
            Divider()
                .padding(.top)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("User Info.")
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("ID: \(user.id)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("Name: \(user.name)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            
        }
        .background(.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 2)
    }
}

struct MapView: View {
    let user: User
    let locationFetcher = LocationFetcher()
    @State var startPosition: MapCameraPosition?
    @State var currentLocation: CLLocationCoordinate2D?

    var body: some View {
        VStack(spacing: 10) {
            
            Spacer(minLength: 10)
            VStack(alignment: .leading) {
                HStack(spacing: 10) {
                    Text("Map")
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    Button {
                        loadLocation()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.primary)
                    }

                }
                
                Divider()

                if let position = startPosition {
                    Map(initialPosition: position) {
                        if let location = currentLocation {
                            Marker("Current Location", coordinate: location)
                                .tint(.red)
                        }
                    }
                    .frame(minHeight: 350)
                } 
                else {
                    ContentUnavailableView {
                        Label("Enable Location", systemImage: "map")
                    } description: {
                        Text("Tap to enable location")
                    } actions: {
                        Button("Enable Location") {
                            locationFetcher.start()
                        }
                    }
                    .frame(minHeight: 350)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 2)
        .onAppear {
            loadLocation()
        }
//        .onChange(of: currentLocation) { _, newLocation in
//            // 當位置更新時，更新地圖位置
//            if let location = newLocation {
//                startPosition = MapCameraPosition.region(
//                    MKCoordinateRegion(
//                        center: location,
//                        span: MKCoordinateSpan(
//                            latitudeDelta: 0.01,
//                            longitudeDelta: 0.01
//                        )
//                    )
//                )
//            }
//        }
    }
    
    func loadLocation() {
        locationFetcher.onLocationUpdate = { location in
            print("Location Updated：\(location)")
            currentLocation = location
            startPosition = MapCameraPosition.region(
                MKCoordinateRegion(
                    center: location,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.3,
                        longitudeDelta: 0.3
                    )
                )
            )
        }
        locationFetcher.start()
    }
}

#Preview {
    UserDetailView(user: User(name: "User01", photoData:User.mockImageData))
}
