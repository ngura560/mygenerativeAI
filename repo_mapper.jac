import repo_util;

node Repo {
    has url: str;
    has local_path: str;
    has file_tree: dict;
    has readme: str;
    has code_context: dict;
    has doc_path: str;
}

walker RepoMapper {
    can run with Repo entry {
        print(" Starting Repo Mapper...");

        if here.url == "" {
            print(" No URL provided for the repository!");
            stop;
        }

        print(" Cloning repository...");
        here.local_path = py.repo_util.clone_repo(here.url);

        if isinstance(here.local_path, dict) {
            print(" Error cloning repo: " + here.local_path["error"]);
            stop;
        };

        print(" Generating file tree...");
        here.file_tree = py.repo_util.generate_file_tree(here.local_path);

        print(" Reading README...");
        here.readme = py.repo_util.read_readme(here.local_path);

        print(" Repo mapping complete!");
    }
}

with entry{

    root spawn RepoMapper();
}