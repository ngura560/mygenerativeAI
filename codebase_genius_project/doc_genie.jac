import os;

node DocGenie {
    has summary: str;
    has repo_ref: ref;  # Reference to the Repo node
}

walker GenerateDocs {
    can run with DocGenie entry {
        if here.repo_ref == null {
            print(f" No repository reference provided to DocGenie!");
            stop;
        }

        print(f" Generating documentation summary...");

        local repo = here.repo_ref;

        # 1 Start with the README
        local readme_section = "No README found.";
        if repo.readme != null and repo.readme != "" {
            readme_section = " **README Summary:**\n" + repo.readme;
        }

        # 2 Summarize file tree
        local tree_section = " **Repository Structure:**\n";
        for dir_name in repo.file_tree.keys() {
            tree_section += f"- {dir_name}\n";
            for file_name in repo.file_tree[dir_name]["files"] {
                tree_section += f"  └── {file_name}\n";
            }
        }

        # 3️⃣ Optionally summarize code context (if available)
        local code_section = "";
        if repo.code_context != null and len(repo.code_context.keys()) > 0 {
            code_section = "\n **Code Summary:**\n";
            for file_name, data in repo.code_context.items() {
                code_section += f"- {file_name}\n";
                if "functions" in data.keys() {
                    code_section += f"  Functions: {data['functions']}\n";
                }
                if "classes" in data.keys() {
                    code_section += f"  Classes: {data['classes']}\n";
                }
            }
        }

        # 4️⃣ Combine sections
        here.summary = readme_section + "\n\n" + tree_section + "\n" + code_section;

        print(" Documentation generated successfully!");
        print("──────────────────────────────");
        print(here.summary);
    }
}
