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
    
    @EnvironmentObject private var drugStore: DrugStore
    
    // MARK: - Body
    
    var body: some View {
        Form {
            makeEnhancedMonitoringSectionView()
            
            makeNameSectionView()
            
            makeHeaderSectionView()
            
            makeStatusSectionView()
            
            makeDrugBoxesPresentationSectionView()
            
            makeDrugCompositionsSectionView()
            
            makeReferenceSectionView()
        }
        .navigationBarTitle(drug.prettyName)
        .onAppear { drugStore.dispatch(action: .drugDetailsDidOpen(drug: drug)) }
        .onDisappear { drugStore.dispatch(action: .drugDetailsDidClose) }
    }
    
    // MARK: - Methods
    
    @ViewBuilder
    private func makeEnhancedMonitoringSectionView() -> some View {
        if
            !drug.enhancedMonitoring.isEmpty &&
                drug.isEnhancedMonitoring
        {
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
    }
    
    private func makeNameSectionView() -> some View {
        Section {
            DrugDetailsHeaderRowComponent(iconSystemName: "pencil.circle.fill",
                                          accentColor: .accent,
                                          title: "§Dénomination du médicament",
                                          value: drug.prettyName)
        }
    }
    
    private func makeHeaderSectionView() -> some View {
        Section {
            DrugDetailsHeaderRowComponent(iconSystemName: "info.circle.fill",
                                          accentColor: .blue,
                                          title: "§Titulaire",
                                          value: drug.holders.joined(separator: "\n"))
            
            DrugDetailsHeaderRowComponent(iconSystemName: "pills.fill",
                                          accentColor: .accent,
                                          title: "§Voie d'administration",
                                          value: drug.administrationRoutes.joined(separator: "\n"))
            
            DrugDetailsHeaderRowComponent(iconSystemName: "waveform.path.ecg.rectangle.fill",
                                          accentColor: .green,
                                          title: "§Forme pharmaceutique",
                                          value: drug.pharmaceuticalForm)
        }
    }
    
    private func makeStatusSectionView() -> some View {
        Section(header: Text("§Statut")) {
            DrugDetailsStatusRowComponent(title: "§État de commercialisation",
                                          value: drug.marketingStatus,
                                          isPositive: drug.isMarketingStatusPositive)
            
            DrugDetailsStatusRowComponent(title: "§Autorisation de mise sur le marché",
                                          value: drug.AMMStatus,
                                          isPositive: drug.isAMMStatusPositive,
                                          subtitle: drug
                                            .AMMDate
                                            .toDate(from: "dd/mm/yyy")?
                                            .toString(dateStyle: .long,
                                                      timeStyle: .none))
            
            if !drug.BDMStatus.isEmpty {
                DrugDetailsStatusRowComponent(title: "§Statut Bases de données sur les Médicaments",
                                              value: drug.BDMStatus,
                                              isPositive: drug.isBDMStatusPositive)
            }
        }
    }
    
    @ViewBuilder
    private func makeDrugBoxesPresentationSectionView() -> some View {
        if !drugStore.currentDrugBoxes.isEmpty {
            Section(header: Text(drugStore.currentDrugBoxes.count > 1 ?
                                    "§Présentations" :
                                    "§Présentation")) {
                ForEach(drugStore.currentDrugBoxes) { drugBox in
                    DrugBoxPresentationRowComponent(drugBox: drugBox)
                }
            }
        }
    }
    
    @ViewBuilder
    private func makeDrugCompositionsSectionView() -> some View {
        if !drugStore.currentDrugBoxes.isEmpty {
            Section(header: Text(drugStore.currentDrugCompositions.count > 1 ?
                                    "§Compositions" :
                                    "§Composition")) {
                ForEach(drugStore.currentDrugCompositions) { drugComposition in
                    DrugCompositionRowComponent(drugComposition: drugComposition)
                }
            }
        }
    }
    
    private func makeReferenceSectionView() -> some View {
        Section(header: Text("§Référence")) {
            DrugDetailsReferenceRowComponent(title: "CIS",
                                             value: drug.cis)
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
        .environmentObject(DrugStore.previewStore)
    }
}
#endif
