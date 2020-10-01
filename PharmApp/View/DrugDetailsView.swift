//
//  DrugDetailsView.swift
//  PharmApp
//
//  Created by Maxime Maheo on 01/10/2020.
//

import SwiftUI

struct DrugDetailsView: View {
    
    // MARK: - Properties
    var drug: Drug
    
    // MARK: - Body
    var body: some View {
        Form {
            Section {
                HStack {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading,
                           spacing: 4) {
                        
                        Text("§Titulaire")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        Text(drug.holders.joined(separator: "\n"))
                    }
                }
                
                HStack {
                    Image(systemName: "pills.fill")
                        .foregroundColor(.accent)
                    
                    VStack(alignment: .leading,
                           spacing: 4) {
                        
                        Text("§Voie d'administration")
                            .font(.headline)
                            .foregroundColor(.accent)
                        
                        Text(drug.administrationRoutes.joined(separator: "\n"))
                    }
                }
                
                HStack {
                    Image(systemName: "waveform.path.ecg.rectangle.fill")
                        .foregroundColor(.green)
                    
                    VStack(alignment: .leading,
                           spacing: 4) {
                        
                        Text("§Forme pharmaceutique")
                            .font(.headline)
                            .foregroundColor(.green)
                        
                        Text(drug.pharmaceuticalForm)
                    }
                }
            }
        }
        .navigationBarTitle(drug.prettyName)
    }
}

#if DEBUG
struct DrugDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DrugDetailsView(drug: Drug.one)
                .preferredColorScheme(.light)
            
            DrugDetailsView(drug: Drug.one)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
                .preferredColorScheme(.dark)
        }
    }
}
#endif
