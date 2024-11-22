import Foundation

func fetchMuscles() async throws -> [Muscle] {
    guard let url = URL(string: "https://shape-factory-5.onrender.com/muscle/getAll") else {
        throw URLError(.badURL) // Lançando um erro se a URL for inválida
    }
    
    // Tenta obter os dados dessa URL
    let (data, _) = try await URLSession.shared.data(from: url)
    
    // Tenta decodificar o valor retornado e os retorna caso bem sucedido
    do {
        let decoder = JSONDecoder()
        let muscles = try decoder.decode([Muscle].self, from: data)
        return muscles
    }
    
    catch {
        throw error
    }
}

func fetchExercises() async throws -> [Exercise] {
    guard let url = URL(string: "https://shape-factory-5.onrender.com/exercise/getAll") else {
        throw URLError(.badURL) // Lançando um erro se a URL for inválida
    }

    // Tenta obter os dados dessa URL
    let (data, _) = try await URLSession.shared.data(from: url)

    // Tenta decodificar o valor retornado e os retorna caso bem sucedido
    do {
        let decoder = JSONDecoder()
        let exercises = try decoder.decode([Exercise].self, from: data)
        return exercises
    }
        
    catch {
        throw error
    }
}
