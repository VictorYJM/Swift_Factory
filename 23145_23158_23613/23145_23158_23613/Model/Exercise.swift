import Foundation

// Identifiable - Identificador único
// Decodable    - Facilitador de conversão de dados externos (JSON) para objetos
struct Exercise: Identifiable, Decodable {
    var exercise_id: Int
    var exercise_name: String
    var exercise_image: String
    var exercise_path: String
    var exercise_muscle: Muscle
    
    // Torna exercise_id como o ID oficial das referências do tipo Exercise
    var id: Int { exercise_id }
    
    // Assimila os dados de um JSON aos campos da struct
    enum CodingKeys: String, CodingKey {
        case exercise_id, exercise_name, exercise_image, exercise_path, exercise_muscle
    }
}
