import SwiftUI

struct Carousel: View {
    @State private var exercises: [Exercise] = []
    @State private var isLoading = true
    @State private var error: Error?

    // Pega os exercícios
    func loadExercises() {
        Task {
            do {
                let exercises = try await fetchExercises()
                self.exercises = exercises
                self.error = nil
            }
            
            catch { self.error = error }
            
            self.isLoading = false
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Carregando Exercícios...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                
                else if let error = error {
                    // Exibe uma mensagem de erro se o erro não for nulo
                    Text("Erro ao carregar dados: \(error.localizedDescription)")
                        .foregroundColor(.red)
                        .padding()
                }
                
                else {
                    // Se os dados forem carregados com sucesso, exibe o carrossel de exercícios
                    TabView {
                        ForEach(exercises) { exercise in
                            ExerciseCards(exercise: exercise)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .padding()
                    
                    // Adicionando o botão para navegar até a tela de inserção
                    NavigationLink(destination: InsertExercise()) {
                        Text("Inserir Novo Exercício")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.top, 20)
                    }
                    .buttonStyle(PlainButtonStyle()) // Para manter o estilo do botão customizado
                }
            }
            .onAppear {
                loadExercises() // Carrega os exercícios quando a tela aparecer
            }
        }
    }
}

#Preview {
    Carousel()
}
