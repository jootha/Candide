import SwiftUI

struct PostDetailView: View {
    let post: Post
    @ObservedObject var postStore = postListGlobalVar
    @State var liked = false
    @State var comment = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Image(systemName: post.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .foregroundColor(.black)
                
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.title).bold()
                        .padding(.vertical, 16)
                    
                    Text(post.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 8)
                    
                    Text("\(post.author.username) • \(post.date)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                }
                
                Text(post.contentText)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.cYellow.opacity(0.9), in: RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 32)
                
                HStack(spacing: 12) {
                    Spacer()
                    
                    Button { liked.toggle() } label: {
                        Label("J’aime (\(post.nbLike + (liked ? 1 : 0)))",
                              systemImage: liked ? "heart.fill" : "heart")
                        .foregroundColor(.black)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.cYellow)
                    
                    ShareLink(item: post.title) {
                        Label("Partager", systemImage: "square.and.arrow.up")
                            .foregroundColor(.black)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.cYellow)
                    
                }
                .padding(.bottom, 32)
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Commentaires")
                        .font(.headline)
                    
                    if let current = postStore.postsList.first(where: { $0.id == post.id }) {
                        VStack(spacing: 8) {
                            ForEach(current.comments) { c in
                                HStack(alignment: .top) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.cPink)
                                            .frame(width: 32, height: 32)
                                        
                                        Image(systemName: c.author.profilePic)
                                            .foregroundColor(.black)
                                        
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        HStack {
                                            Text(c.author.username).bold()
                                            
                                            Text("• \(c.date)")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                            
                                        }
                                        
                                        Text(c.commentText)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(8)
                                .background(Color.cYellow, in: RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    } else {
                        Text("Aucun commentaire")
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack(spacing: 8) {
                        TextField("Ajouter un commentaire…", text: $comment)
                            .textFieldStyle(.plain)
                        
                        Button {
                            let trimmed = comment.trimmingCharacters(in: .whitespacesAndNewlines)
                            guard !trimmed.isEmpty else { return }
                            let newComment = Comment(
                                commentText: trimmed,
                                date: Date.now.formatted(date: .abbreviated, time: .omitted),
                                author: users.first ?? Profile(username: "Utilisateur", profilePic: "person.circle")
                            )
                            postStore.addComment(to: post.id, comment: newComment)
                            comment = ""
                        } label: { Image(systemName: "paperplane.fill").foregroundColor(.black) }
                            .disabled(comment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .padding(8)
                    .background(Color.cYellow, in: RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding()
            .background(
                Color.cYellow.opacity(0.9),
                in: RoundedRectangle(cornerRadius: 24)
            )
            .padding()
        }
        .background(Color.cGreen.ignoresSafeArea())
        .toolbarBackground(.cGreen, for: .navigationBar)
//        .navigationTitle("Détail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PostDetailView(post: posts[1])
    }
}
