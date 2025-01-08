//
//  UserDetailView.swift
//  UserLibrary
//
//  Created by Gary on 8/1/2025.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    @State private var isAnimated = false
    @State private var rotateAmount = 0.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack(alignment: .top) {
                    VStack(spacing: 0) {
                        Spacer(minLength: 50)
                        
                        VStack(spacing: 8) {
                            Text(user.name)
                                .font(.title.bold())
                        }
                        .padding(.top, 40)
                        
                        Divider()
                            .padding(.vertical)
                        
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
                    
                    user.photoImage?
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.white, lineWidth: 2))
                        .shadow(radius: 3)
                        .offset(y: -80)
                }
            }
            .padding(.top, 180)
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

#Preview {
    UserDetailView(user: User(name: "User01", photoData:User.mockImageData))
}
