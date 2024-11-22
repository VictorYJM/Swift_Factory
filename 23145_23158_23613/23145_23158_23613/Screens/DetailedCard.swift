import SwiftUI

struct DetailedCard: View {
    var exercise: Exercise
    
    var body: some View {
        VStack{
            // Pega a imagem, na internet, vinculada ao objeto Exercise e a exibe
            AsyncImage(url: URL(string: exercise.exercise_image)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
                    .cornerRadius(10)
            }
            placeholder: {
                ProgressView()
                    .frame(width: 300, height: 200)
            }
            
            Text("Exercício \(exercise.exercise_id)º")
                .bold()
                .foregroundColor(Color(red: 0.8, green: 0.5, blue: 0.1))
            
            Text(exercise.exercise_name)
                .font(.headline)
                .padding(.bottom, 8)
            
            Text("Músculo: \(exercise.exercise_muscle.muscle_name)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("\(exercise.exercise_path)")
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding(.top, 4)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .frame(width: 300, height: 400)
    }
}

#Preview {
    DetailedCard(exercise: Exercise(
        exercise_id: 34,
        exercise_name: "Abdominal Diagonal Alternado",
        exercise_image: "https://ddolnnrjmlpqgerhzrgz.supabase.co/storage/v1/object/images/Abdominal%20diagonal%20alternado.PNG",
        exercise_path: "https://youtu.be/IF6Y8UkS0W8?si=E9KumllcDe1gwK5j",
        exercise_muscle: Muscle(muscle_id: 7, muscle_name: "Abdômen")
    ))
}
