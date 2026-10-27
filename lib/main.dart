
import 'package:flutter/material.dart';

class Pet {
final String nome;
final String especie;
final int idade;
final bool eCastrado;
Pet({
required this.nome,
required this.especie,
required this.idade,
required this.eCastrado,
});
}

void main() => runApp(
  const MaterialApp(
    home: FormularioExemplo(),
    debugShowCheckedModeBanner: false,
  ),
);

class FormularioExemplo extends StatefulWidget {
  const FormularioExemplo({super.key});

  @override
  State<FormularioExemplo> createState() =>
      _FormularioExemploState();
}

class _FormularioExemploState
    extends State<FormularioExemplo> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();

  String? _especie;
  bool _castrado = false;

  final List<Pet> _petsCadastrados = [];
  void _submeterFormulario() {
    if (_formKey.currentState!.validate()) {
      setState(() {
      _petsCadastrados.add(Pet(
        nome: _nomeController.text,
        especie: _especie,
        idade: int.parse(_idadeController.text),
        eCastrado: _castrado,
        ));
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _nomeController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Pets'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),

              // Nome do Pet
              TextFormField(
                controller: _nomeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Nome do Pet',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.pets),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Informe o nome do pet!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Espécie
              DropdownButtonFormField<String>(
                value: _especie,
                decoration: const InputDecoration(
                  labelText: 'Espécie',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                hint: const Text('Selecione a espécie'),
                items: const [
                 
                  DropdownMenuItem(
                    value: 'Cachorro',
                    child: Text('Cachorro'),
                  ),

                  DropdownMenuItem(
                    value: 'rato',
                    child: Text('rato'),
                  ),
                  
                  DropdownMenuItem(
                    value: 'gato',
                    child: Text('gato'),
                  ),

                  DropdownMenuItem(
                    value: 'passaro',
                    child: Text('passaro'),
                  ),

                  DropdownMenuItem(
                    value: 'coelho',
                    child: Text('coelho'),
                  ),
                 
                  DropdownMenuItem(
                    value: 'Outro',
                    child: Text('Outro'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _especie = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Selecione a espécie do pet!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Idade em anos
              TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade em Anos',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe a idade do pet!';
                  }

                  final idade = int.tryParse(value.trim());

                  if (idade == null) {
                    return 'Informe uma idade numérica inteira!';
                  }

                  if (idade <= 0) {
                    return 'A idade deve ser maior que zero!';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Termo de Castração
              CheckboxListTile(
                title: const Text('Termo de Castração'),
                subtitle: const Text(
                  'O animal já é castrado?',
                ),
                value: _castrado,
                activeColor: Colors.teal,
                controlAffinity:
                    ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _castrado = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Senha
              TextFormField(
                controller: _senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Botão de cadastro
              ElevatedButton(
                onPressed: _submeterFormulario,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 16),



                ),
              ),

              ListView.builder(
                  itemCount: _petsCadastrados.length,
                  itemBuilder: (context, index) {
                  final pet = _petsCadastrados[index];
                  return Card(
                  child: ListTile(
                  leading: CircleAvatar(
                  child: Text(pet.especie[0]), // Primeira letra da espécie
                  ),
                  title: Text(pet.nome),
                  subtitle: Text('${pet.especie} • ${pet.idade} ano(s)'),
                  trailing: Icon(
                  pet.eCastrado ? Icons.check_circle : Icons.cancel,
                  color: pet.eCastrado ? Colors.green : Colors.grey,
                  ),
                  ),
                  );
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}