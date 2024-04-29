import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  final String? recipeName;

  const RecipeScreen({Key? key, this.recipeName}) : super(key: key);

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final TextEditingController _recipeNameController = TextEditingController();
  final List<TextEditingController> _ingredientControllers = [];
  final List<TextEditingController> _instructionControllers = [];

  @override
  void initState() {
    super.initState();
    if (widget.recipeName != null) {
      _recipeNameController.text = widget.recipeName!;
    }
    _ingredientControllers.add(TextEditingController());
    _instructionControllers.add(TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeName != null ? 'Edit Recipe' : 'Add Recipe'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _recipeNameController,
              decoration: InputDecoration(labelText: 'Recipe Name'),
            ),
            SizedBox(height: 20.0),
            Text('Ingredients'),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _ingredientControllers.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _ingredientControllers[index],
                        decoration: InputDecoration(
                          labelText: 'Ingredient ${index + 1}',
                          hintText: 'Enter ingredient',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          _ingredientControllers.removeAt(index);
                        });
                      },
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20.0),
            Text('Instructions'),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _instructionControllers.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _instructionControllers[index],
                        decoration: InputDecoration(
                          labelText: 'Instruction ${index + 1}',
                          hintText: 'Enter instruction',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          _instructionControllers.removeAt(index);
                        });
                      },
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _saveRecipe,
              child: Text('Save Recipe'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _ingredientControllers.add(TextEditingController());
            _instructionControllers.add(TextEditingController());
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _saveRecipe() {
    String recipeName = _recipeNameController.text.trim();
    List<String> ingredients = _ingredientControllers.map((controller) => controller.text.trim()).toList();
    List<String> instructions = _instructionControllers.map((controller) => controller.text.trim()).toList();

    if (recipeName.isNotEmpty) {
      if (widget.recipeName != null) {
        print('Editing recipe: ${widget.recipeName}');
        print('Updated Recipe Name: $recipeName');
        print('Updated Ingredients: $ingredients');
        print('Updated Instructions: $instructions');

      } else {
        print('Adding new recipe: $recipeName');
        print('Ingredients: $ingredients');
        print('Instructions: $instructions');

      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Recipe name cannot be empty."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}
