import repo_mapper;
import code_analyzer;
import doc_genie;

walker map_repo {
    can run with repo_mapper.Repo entry {
        here -> repo_mapper.RepoMapper;
    }
}

walker analyze_code {
    can run with code_analyzer.Repo entry {
        here -> code_analyzer.CodeAnalyzer;
    }
}

walker generate_docs {
    can run with doc_genie.DocGenie entry {
        here -> doc_genie.GenerateDocs;
    }
}

walker finalize {
    can run with doc_genie.DocGenie entry {
        here -> doc_genie.Finalize;
    }
}

with entry {
    print("🚀 Starting Codebase Genius...");

    # 1. Create Repo node
    spawn root +>:repo_mapper.Repo:+> repo_node;
    repo_node.url = "https://github.com/ngura560/mygenerativeAI";

    # 2. Create DocGenie node
    spawn root +>:doc_genie.DocGenie:+> doc_node;
    doc_node.repo_ref = repo_node;

    # 3. Run the RepoMapper walker
    root spawn map_repo() as mapper;
    mapper.repo_node = repo_node;
    mapper -> map_repo();

    # 4. Run the CodeAnalyzer walker
    root spawn analyze_code() as analyzer;
    analyzer.repo_node = repo_node;
    analyzer -> analyze_code();

    # 5. Run the DocGenie walker
    root spawn generate_docs() as doc_genie_walker;
    doc_genie_walker.doc_node = doc_node;
    doc_genie_walker -> generate_docs();

    # 6. Run the Finalize walker
    root spawn finalize() as finalizer;
    finalizer.doc_node = doc_node;
    finalizer -> finalize();

    print("✅ Codebase Genius completed successfully!");
}