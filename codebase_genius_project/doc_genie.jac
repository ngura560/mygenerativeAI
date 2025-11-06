import os;

node DocGenie {
    has summary: str;
    has repo_ref: ref;  # Reference to the Repo node
}

    can run with DocGenie entry {
         if here.repo_ref == null {
            print("❌ No repository reference provided to DocGenie!");
            stop;
        }

        print("📄 Generating documentation summary...");
        repo = here.repo_ref;

        # 1️⃣ README section
        readme_section = "No README found.";
        if repo.readme != null and repo.readme != "" {
            readme_section = "**README Summary:**\n" + repo.readme;
        }

        # 2️⃣ File tree section
        tree_section = "**Repository Structure:**\n";
        for dir_name in repo.file_tree.keys() {
            tree_section = tree_section + "- " + dir_name + "\n";
            for file_name in repo.file_tree[dir_name]["files"] {
                tree_section = tree_section + "  └── " + file_name + "\n";
            }
        }

        # 3️⃣ Code summary (optional)
        code_section = "";
        if repo.code_context != null and len(repo.code_context.keys()) > 0 {
            code_section = "\n**Code Summary:**\n";
            for (file_name, data) in repo.code_context.items() {
                code_section = code_section + "- " + file_name + "\n";
                if "functions" in data.keys() {
                    code_section = code_section + "  Functions: " + data["functions"] + "\n";
                }
                if "classes" in data.keys() {
                    code_section = code_section + "  Classes: " + data["classes"] + "\n";
                }
            }
        }

        # 4️⃣ Combine all sections
        here.summary = readme_section + "\n\n" + tree_section + "\n" + code_section;

        print("✅ Documentation generated successfully!");
        print("──────────────────────────────");
        print(here.summary);
    }
