import SwiftUI

struct PostDetail2: View {
    let post: Post
    @State var liked = false
    @State var comment = ""

    init(post: Post = posts[1]) { self.post = post }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                Image(systemName: post.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .foregroundColor(.black)

                VStack(alignment: .leading, spacing: 4) {
                    Text(post.title)
                        .font(.title).bold()
                    Text(post.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("\(post.author.username) • \(post.date)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Text(post.contentText)
                    .padding()
                    .background(Color.cYellow.opacity(0.9), in: RoundedRectangle(cornerRadius: 12))

                HStack(spacing: 12) {
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

                    Spacer()
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Commentaires")
                        .font(.headline)

                    let c = post.comments
                    HStack(alignment: .top, spacing: 8) {
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

                    HStack(spacing: 8) {
                        TextField("Ajouter un commentaire…", text: $comment)
                            .textFieldStyle(.plain)
                        Button {
                            comment = ""
                        } label: {
                            Image(systemName: "paperplane.fill").foregroundColor(.black)
                        }
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
        .navigationTitle("Détail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PostDetail2()
    }
}
