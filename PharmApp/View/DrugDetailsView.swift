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
                makeStatusRowView(title: "§État de commercialisation",
                                  value: drug.marketingStatus,
                                  isPositive: drug.isMarketingStatusPositive)

                makeStatusRowView(title: "§Autorisation de mise sur le marché",
                                  value: drug.AMMStatus,
                                  isPositive: drug.isAMMStatusPositive,
                                  subtitle: drug
                                      .AMMDate
                                      .toDate(from: "dd/mm/yyy")?
                                      .toString(dateStyle: .long,
                                                timeStyle: .none))

                if !drug.BDMStatus.isEmpty {
                    makeStatusRowView(title: "§Statut Bases de données sur les Médicaments",
                                      value: drug.BDMStatus,
                                      isPositive: drug.isBDMStatusPositive)
                }
            }

            Section(header: Text("§Référence")) {
                makeReferenceRowView(title: "§Code CIS",
                                     value: drug.cis)

                drugStore.currentDrugBox.map {
                    makeReferenceRowView(title: "§Code CIP13",
                                         value: $0.cip13)
                }
            }
        }
        .navigationBarTitle(drug.prettyName)
        .onAppear { drugStore.dispatch(action: .drugDetailsDidOpen(drug: drug)) }
        .onDisappear { drugStore.dispatch(action: .drugDetailsDidClose) }
    }

    // MARK: - Methods

    private func makeHeaderRowView(iconSystemName: String,
                                   accentColor: Color,
                                   title: String,
                                   value: String) -> some View
    {
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

    private func makeStatusRowView(title: String,
                                   value: String,
                                   isPositive: Bool,
                                   subtitle: String? = nil) -> some View
    {
        HStack {
            Image(systemName: isPositive ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                .foregroundColor(isPositive ? .green : .red)

            VStack(alignment: .leading,
                   spacing: 4) {
                Text(title)

                Text(value)
                    .font(.callout)
                    .foregroundColor(isPositive ? .green : .red)

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
            .environmentObject(DrugStore.previewStore)
        }
    }
#endif
