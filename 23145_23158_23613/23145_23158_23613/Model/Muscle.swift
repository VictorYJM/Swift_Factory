import Foundation

// Identifiable - Identificador único
// Decodable    - Facilitador de conversão de dados externos (JSON) para objetos
// Hashable     - Permite que o swift armazene dados e os compare
struct Muscle: Identifiable, Decodable, Hashable {
    var muscle_id: Int
    var muscle_name: String
    
    // Torna muscle_id como o ID oficial das referências do tipo Muscle
    var id: Int { muscle_id }
    
    // Assimila os dados de um JSON aos campos da struct
    enum CodingKeys: String, CodingKey {
        case muscle_id, muscle_name
    }
}
