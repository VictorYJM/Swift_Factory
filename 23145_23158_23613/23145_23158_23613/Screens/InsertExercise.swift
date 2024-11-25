import SwiftUI

struct InsertExercise: View {
    @State private var selectedMuscle: Muscle? = nil
    @State private var muscles: [Muscle] = []
    @State private var selectedImage: UIImage? = nil
    @State private var isLoading: Bool = true
    @State private var isSubmitting: Bool = false
    @State private var isImagePickerPresented: Bool = false
    @State private var name: String = ""
    @State private var video: String = ""
    @State private var errorMessage: String? = nil
    
    // Carregar os músculos da API
    func loadMuscles() {
        Task {
            do {
                muscles = try await fetchMuscles()
                isLoading = false
            } catch {
                print("Erro ao carregar músculos: \(error)")
                isLoading = false
            }
        }
    }
    
    // Função para enviar os dados para o backend
    func submitExercise() {
        // Verificando se os dados necessários estão preenchidos
        guard let selectedMuscle = selectedMuscle else {
            errorMessage = "Por favor, selecione um músculo."
            return
        }
        
        guard let image = selectedImage, let imageData = image.jpegData(compressionQuality: 0.7) else {
            errorMessage = "Por favor, selecione uma imagem."
            return
        }
        
        guard !name.isEmpty else {
            errorMessage = "Por favor, insira o nome do exercício."
            return
        }
        
        guard !video.isEmpty else {
            errorMessage = "Por favor, insira a URL do vídeo."
            return
        }
        
        // Limpa a mensagem de erro antes de tentar enviar
        errorMessage = nil
        isSubmitting = true
        
        // Gerando um nome único para a imagem usando UUID
        let imageName = UUID().uuidString + ".jpg"
        
        let url = URL(string: "https://shape-factory-5.onrender.com/exercise/insert")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // Adicionando o muscleId
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"muscleId\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(selectedMuscle.id)\r\n".data(using: .utf8)!)
        
        // Adicionando o nome do exercício
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"name\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(name)\r\n".data(using: .utf8)!)
        
        // Adicionando o vídeo
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"path\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(video)\r\n".data(using: .utf8)!)
        
        // Adicionando a imagem
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(imageName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        // Enviando a requisição
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isSubmitting = false
            }
            
            if let error = error {
                print("Erro ao enviar dados: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    errorMessage = "Erro ao enviar os dados. Tente novamente."
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("Erro na resposta do servidor: Status code \(httpResponse.statusCode)")
                    DispatchQueue.main.async {
                        errorMessage = "Erro na resposta do servidor. Código: \(httpResponse.statusCode)"
                    }
                    return
                }
                print("Exercício inserido com sucesso!")
                DispatchQueue.main.async {
                    errorMessage = nil
                    name = ""
                    video = ""
                    selectedImage = nil // Limpar imagem após a submissão
                    isImagePickerPresented = false // Fechar a imagem picker após a submissão
                }
            }
        }
        
        task.resume()
    }


    
    var body: some View {
        VStack {
            // Se os músculos não estão em exibição, exibe uma barra de progresso
            if isLoading {
                ProgressView("Carregando músculos...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
            
            // Exibe os músculos em um ComboBox
            else {
                Picker("Escolha um músculo", selection: $selectedMuscle) {
                    ForEach(muscles) { muscle in
                        Text(muscle.muscle_name)
                            .tag(muscle as Muscle?) // Marcação das opções
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .cornerRadius(8)
                .padding(.horizontal)
                .padding()
                
                // Campo para inserir o nome do exercício
                TextField("Digite o nome do exercício", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Campo para inserir a URL do exercício
                TextField("Digite a URL do exercício", text: $video)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Botão para adicionar imagens
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    Text("Selecionar Imagem")
                }
                .padding()
                
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding()
                }
                
                // Exibindo mensagens de erro
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                if isSubmitting {
                    ProgressView("Enviando dados...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                
                Button("Inserir Exercício"){
                    submitExercise() // Chama a função para submeter os dados
                }
                .padding()
                .disabled(isSubmitting) // Desabilita o botão enquanto está enviando
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .frame(width: 300, height: 400)
        .onAppear {
            loadMuscles()  // Carrega os músculos assim que a View aparecer
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage, isImagePickerPresented: $isImagePickerPresented)
        }
    }
}

#Preview {
    InsertExercise()
}
