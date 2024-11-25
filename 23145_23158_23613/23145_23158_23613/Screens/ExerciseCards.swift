import SwiftUI

struct ExerciseCards: View {
    var exercise: Exercise
    
    var body: some View {
        VStack {
            // Pega a imagem, na internet, vinculada ao objeto Exercise e a exibe
            AsyncImage(url: URL(string: exercise.exercise_image)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
                    .cornerRadius(10)
            }
            // Enquanto a imagem não está carregada, exibe uma barra de progresso
            placeholder: {
                ProgressView()
                    .frame(width: 300, height: 200)
            }
            
            // Exibe a identificação do objeto Exercise
            Text("Exercício \(exercise.exercise_id)º")
                .bold()
                .foregroundColor(Color(red: 0.8, green: 0.5, blue: 0.1))

            // Botão que navega para a tela de detalhes
            NavigationLink(destination: DetailedCard(exercise: exercise)) {
                Text("Ver Detalhes")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .frame(width: 300, height: 400)
    }
}

#Preview {
    ExerciseCards(exercise: Exercise(
        exercise_id: 34,  // Exemplo de ID para o exercício
        exercise_name: "Abdominal Diagonal Alternado",
        exercise_image: "https://ddolnnrjmlpqgerhzrgz.supabase.co/storage/v1/object/images/Abdominal%20diagonal%20alternado.PNG",
        exercise_path: "https://youtu.be/IF6Y8UkS0W8?si=E9KumllcDe1gwK5j",
        exercise_muscle: Muscle(muscle_id: 7, muscle_name: "Abdômen")  // Exemplo de ID para o músculo
    ))
}
