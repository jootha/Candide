import SwiftUI

struct ForumView: View {
    @ObservedObject var postStore = postListGlobalVar
    @State var selected: Filter?
    
    var categories: [Filter] { Filter.allCases }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Color.cGreen.frame(height: 120)
                    Color.cGreen
                }.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        
                        NavigationLink { AddPostView() } label: {
                            Image(systemName: "plus")
                                .labelStyle(.iconOnly)
                                .padding(8)
                                .background(.cDarkBlue)
                                .foregroundStyle(.cOrange)
                                .cornerRadius(32)
                                .font(.system(size: 32))
                                .bold()
                                .padding(12)
                        }
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(categories, id: \.self) { cat in
                                Button {
                                    withAnimation(.easeInOut) {
                                        selected = (selected == cat) ? nil : cat
                                    }
                                } label: {
                                    Text(cat.rawValue)
                                        .lineLimit(1)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 10)
                                        .background(Capsule().fill(selected == cat ? .cDarkBlue.opacity(0.7) : .white.opacity(0.15)))
                                        .overlay(Capsule().stroke(.white.opacity(0.3), lineWidth: 1))
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .padding(.horizontal, 18)
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 24)

                    ScrollView {
                        ZStack {
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.black.opacity(0.08), lineWidth: 1)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color.cYellow)
                                )

                            contentList.padding(.bottom, 120)
                        }
                        .padding(.horizontal, 8)
                    }
                    .frame(maxHeight: .infinity)
                    .padding(.bottom, 0)
                    .animation(.easeInOut, value: selected)
                }
            }
            .navigationTitle("Forum")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Forum")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    
                }
            }
            .toolbarBackground(.cDarkBlue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        
    }
    
    var filteredItems: [Post] {
        guard let sel = selected else { return postStore.postsList }
        return postStore.postsList.filter { $0.filter == sel }
    }
    
    var contentList: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Posts")
                .font(.system(size: 28, weight: .bold))
                .padding(.horizontal, 24)
                .padding(.top, 24)
            
            if filteredItems.isEmpty {
                Text("Aucun post pour cette catégorie.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
            } else {
                VStack(spacing: 0) {
                    ForEach(Array(filteredItems.enumerated()), id: \.offset) { idx, post in
                        NavigationLink { PostDetailView(post: post) } label: {
                            Row(post: post)
                        }
                        .buttonStyle(.plain)
                        
                        if idx < filteredItems.count - 1 {
                            Divider().padding(.leading, 92).padding(.trailing, 12)
                        }
                    }
                }
                .padding(.vertical, 12)
            }
        }
    }
}

struct Row: View {
    let post: Post
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous).fill(Color.cPink)
                Image(systemName: post.image).resizable().scaledToFit().padding(14).foregroundStyle(.primary)
            }
            .frame(width: 72, height: 72)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(post.title).font(.headline).lineLimit(1)
                Text(post.description).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                HStack(spacing: 8) {
                    Label(post.author.username, systemImage: post.author.profilePic).font(.footnote).foregroundStyle(.secondary).lineLimit(1)
                    Text("•").font(.footnote).foregroundStyle(.secondary)
                    Text(post.date).font(.footnote).foregroundStyle(.secondary)
                    HStack(spacing: 4) { Image(systemName: "heart"); Text("\(post.nbLike)") }.font(.footnote).foregroundStyle(.secondary)
                }
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundStyle(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .contentShape(Rectangle())
    }
}


#Preview {
    ForumView()
}
