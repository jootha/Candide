import SwiftUI

struct ForumView: View {
    let postsData: [Post] = posts
    @State var selected: PostCategory?

    var categories: [PostCategory] { [.plantes, .medecine, .consommable, .engrais] }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    Color.cGreen.frame(height: 120)
                    Color.cGreen
                }.ignoresSafeArea()

                VStack(spacing: 0) {
                    Text("Forum")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, -50)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(categories, id: \.self) { cat in
                                Button {
                                    selected = (selected == cat) ? nil : cat
                                } label: {
                                    Text(cat.rawValue)
                                        .lineLimit(1)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 10)
                                        .background(
                                            Capsule().fill(selected == cat ? .white.opacity(0.25) : .white.opacity(0.15))
                                        )
                                        .overlay(Capsule().stroke(.white.opacity(0.3), lineWidth: 1))
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .padding(.horizontal, 18)
                    }
                    .padding(.top, 36)

                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.black.opacity(0.08), lineWidth: 1)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.cYellow)
                            )
                        contentList
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 24)     
                    .padding(.bottom, 24)

                    Spacer(minLength: 0)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink { AddPostView() } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .symbolRenderingMode(.hierarchical)
                    }
                }
            }
        }
    }

    var filteredItems: [Post] {
        guard let sel = selected else { return postsData }
        return postsData.filter { $0.category == sel }
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
                        NavigationLink { destination(forIndex: idx) } label: {
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

    @ViewBuilder
    func destination(forIndex idx: Int) -> some View {
        switch idx {
        case 0: PostDetail1()
        case 1: PostDetail2()
        default: PostDetail3()
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
