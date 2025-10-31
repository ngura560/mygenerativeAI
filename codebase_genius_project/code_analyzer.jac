import os;
import ast;  # Python’s built-in code parser

node CodeFile {
    has path: str;
    has functions: list;
    has classes: list;
}

walker CodeAnalyzer {
    can run with CodeFile entry {
        print(f" Analyzing {here.path} ...");

        # Read and parse the Python file
        local code = "";
        with open(here.path, "r") as f {
            code = f.read();
        }

        local tree = py.ast.parse(code);

        # Collect function and class names
        here.functions = [];
        here.classes = [];
        for node in tree.body {
            if isinstance(node, py.ast.FunctionDef) {
                here.functions.append(node.name);
            }
            elif isinstance(node, py.ast.ClassDef) {
                here.classes.append(node.name);
            }
        }

        print(f"   Functions: {here.functions}");
        print(f"   Classes: {here.classes}");
    }
}

with entry {
    # Point this to any Python file in your repo
    spawn here ++> CodeFile as file_node;
    file_node.path = "./repo_util.py";
    file_node -> CodeAnalyzer;
}
