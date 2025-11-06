import repo_mapper;
import code_analyzer;
import doc_genie;

# --- Function: Map repository files ---
def map_repo() {
    print("🗂️ Mapping repository files...");
    repo_mapper.RepoMapper();
}

# --- Function: Analyze code ---
def analyze_code() {
    print("🔍 Analyzing code files...");
    code_analyzer.CodeAnalyzer();
}

# --- Function: Generate documentation ---
def generate_docs() {
    print("📝 Generating documentation...");
    doc_genie.GenerateDocs();
}

# --- MAIN ENTRY POINT ---
with entry {
    print("🚀 Starting CodeBase Genius...");

    # Step 1: Map repo
    map_repo();

    # Step 2: Analyze code
    analyze_code();

    # Step 3: Generate docs
    generate_docs();

    print("🎉 CodeBase Genius complete.");
}
