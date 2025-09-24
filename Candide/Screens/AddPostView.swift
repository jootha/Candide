import SwiftUI

struct AddPostView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var postStore = postListGlobalVar
    @State var title = ""
    @State var description = ""
    @State var contentText = ""
    @State var selectedFilter: Filter = .beginnerFriendly
    @State var selectedSymbol = "humidity.fill"
    @State var showingSymbolPicker = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Aperçu")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        HStack(spacing: 16) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .fill(Color.cPink)
                                Image(systemName: selectedSymbol)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(14)
                                    .foregroundStyle(.primary)
                            }
                            .frame(width: 72, height: 72)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text(title.isEmpty ? "Titre du post" : title)
                                    .font(.headline)
                                    .lineLimit(1)
                                    .foregroundColor(title.isEmpty ? .secondary : .primary)
                                
                                Text(description.isEmpty ? "Description du post" : description)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                                
                                HStack(spacing: 8) {
                                    Label("Utilisateur", systemImage: "person.circle")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                    Text("•")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                    Text("Aujourd'hui")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                    HStack(spacing: 4) {
                                        Image(systemName: "heart")
                                        Text("0")
                                    }
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                }
                            }
                            
                            Spacer()
                        }
                        .padding(16)
                        .background(Color.cYellow.opacity(0.3), in: RoundedRectangle(cornerRadius: 12))
                    }
                    
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Titre")
                                .font(.headline)
                            TextField("Entrez le titre de votre post", text: $title)
                                .textFieldStyle(.roundedBorder)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.headline)
                            TextField("Entrez une courte description", text: $description)
                                .textFieldStyle(.roundedBorder)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Contenu")
                                .font(.headline)
                            TextField("Écrivez le contenu de votre post...", text: $contentText, axis: .vertical)
                                .textFieldStyle(.roundedBorder)
                                .lineLimit(5...10)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Catégorie")
                                .font(.headline)
                            Picker("Filtre", selection: $selectedFilter) {
                                ForEach(Filter.allCases, id: \.self) { filter in
                                    Text(filter.rawValue).tag(filter)
                                }
                            }
                            .pickerStyle(.menu)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 8))
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Image")
                                .font(.headline)
                            
                            Button {
                                showingSymbolPicker = true
                            } label: {
                                HStack {
                                    Image(systemName: selectedSymbol)
                                        .foregroundColor(.primary)
                                    Text("Choisir une image")
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                                        .font(.caption)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }
                }
                .padding()
                .background(
                    Color.cYellow.opacity(0.9),
                    in: RoundedRectangle(cornerRadius: 24)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.black.opacity(0.08), lineWidth: 1)
                )
                .padding()
            }
            .background(Color.cGreen.ignoresSafeArea())
            .navigationTitle("Nouveau Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Annuler") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Publier") {
                        let newPost = Post(
                            title: title,
                            image: selectedSymbol,
                            contentText: contentText,
                            description: description,
                            author: users.first ?? Profile(username: "Utilisateur", profilePic: "person.circle"),
                            date: Date.now.formatted(date: .abbreviated, time: .omitted),
                            nbLike: 0,
                            filter: selectedFilter,
                            comments: []
                        )
                        postStore.addPost(newPost)
                        dismiss()
                    }
                    .disabled(title.isEmpty || description.isEmpty || contentText.isEmpty)
                }
            }
            .sheet(isPresented: $showingSymbolPicker) {
                SymbolPickerView(selectedSymbol: $selectedSymbol)
            }
        }
    }
}

struct SymbolPickerView: View {
    @Binding var selectedSymbol: String
    @Environment(\.dismiss) var dismiss
    @State var query: String = ""
    let columns = Array(repeating: GridItem(.flexible()), count: 6)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        TextField("Rechercher une image", text: $query)
                            .textFieldStyle(.plain)
                    }
                    .padding(10)
                    .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)
                .padding(.top)
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(filteredSymbols, id: \.self) { symbol in
                        Button {
                            selectedSymbol = symbol
                            dismiss()
                        } label: {
                            Image(systemName: symbol)
                                .font(.title2)
                                .foregroundColor(selectedSymbol == symbol ? .white : .primary)
                                .frame(width: 50, height: 50)
                                .background(
                                    Circle()
                                        .fill(selectedSymbol == symbol ? Color.cPink : Color(.systemGray6))
                                )
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Choisir une image")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fermer") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    var filteredSymbols: [String] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if q.isEmpty { return availableSFSymbols }
        return availableSFSymbols.filter { $0.lowercased().contains(q) }
    }
}

#Preview {
    AddPostView()
}
