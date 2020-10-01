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
            
            if
                !drug.enhancedMonitoring.isEmpty &&
                    drug.enhancedMonitoring == "Oui" {
                Section {
                    HStack {
                        Spacer()
                        Image(systemName: "exclamationmark.triangle.fill")
                        
                        Text("§Surveillance renforcée")
                        Spacer()
                    }
                    .foregroundColor(.red)
                }
            }
            
            Section {
                makeHeaderRowView(iconSystemName: "pencil.circle.fill",
                                  accentColor: .accentColor,
                                  title: "§Dénomination du médicament",
                                  value: drug.prettyName)
            }
            
            Section {
                makeHeaderRowView(iconSystemName: "info.circle.fill",
                                  accentColor: .blue,
                                  title: "§Titulaire",
                                  value: drug.holders.joined(separator: "\n"))
                
                makeHeaderRowView(iconSystemName: "pills.fill",
                                  accentColor: .accent,
                                  title: "§Voie d'administration",
                                  value: drug.administrationRoutes.joined(separator: "\n"))
                
                makeHeaderRowView(iconSystemName: "waveform.path.ecg.rectangle.fill",
                                  accentColor: .green,
                                  title: "§Forme pharmaceutique",
                                  value: drug.pharmaceuticalForm)
            }
            
            Section(header: Text("§Statut")) {
                makeStatusRowView(iconSystemName: "checkmark.circle.fill",
                                  accentColor: .green,
                                  title: "§État de commercialisation",
                                  value: drug.marketingStatus)
                
                makeStatusRowView(iconSystemName: "checkmark.circle.fill",
                                  accentColor: .green,
                                  title: "§Autorisation de mise sur le marché",
                                  value: drug.AMMStatus,
                                  subtitle: drug
                                    .AMMDate
                                    .toDate(from: "dd/mm/yyy")?
                                    .toString(dateStyle: .long,
                                              timeStyle: .none))
                
                if !drug.BDMStatus.isEmpty {
                    makeStatusRowView(iconSystemName: "checkmark.circle.fill",
                                      accentColor: .green,
                                      title: "§Statut Bases de données sur les Médicaments",
                                      value: drug.BDMStatus)
                }
            }
            
            Section(header: Text("§Référence")) {
                makeReferenceRowView(title: "§Code CIS",
                                     value: drug.cis)
            }
        }
        .navigationBarTitle(drug.prettyName)
    }
    
    // MARK: - Methods
    private func makeHeaderRowView(iconSystemName: String,
                                   accentColor: Color,
                                   title: String,
                                   value: String) -> some View {
        HStack {
            Image(systemName: iconSystemName)
                .foregroundColor(accentColor)
            
            VStack(alignment: .leading,
                   spacing: 4) {
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(accentColor)
                
                Text(value)
                    .font(.callout)
            }
        }
    }
    
    private func makeStatusRowView(iconSystemName: String,
                                   accentColor: Color,
                                   title: String,
                                   value: String,
                                   subtitle: String? = nil) -> some View {
        HStack {
            Image(systemName: iconSystemName)
                .foregroundColor(accentColor)
            
            VStack(alignment: .leading,
                   spacing: 4) {
                
                Text(title)
                
                Text(value)
                    .font(.callout)
                    .foregroundColor(accentColor)
                
                subtitle.map {
                    Text($0)
                        .font(.caption)
                        .italic()
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    private func makeReferenceRowView(title: String, value: String) -> some View {
        HStack {
            Text(title)
            
            Spacer()
            
            Text(value)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
    
}

#if DEBUG
struct DrugDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DrugDetailsView(drug: Drug.one)
                .preferredColorScheme(.light)
            
            DrugDetailsView(drug: Drug.one)
                .preferredColorScheme(.dark)
            
            DrugDetailsView(drug: Drug.one)
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
    }
}
#endif
