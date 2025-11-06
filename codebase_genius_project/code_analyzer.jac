include repo_util;


walker CodeAnalyzer {
    has repo: Repository;

    def parse_file(file_path: str) -> dict {
        if (not (file_path.ends_with(".py") or file_path.ends_with(".jac"))) {
            return {};
        }

        code = std.read(file_path);

        json_str = llm(
            prompt=f"""Extract classes and functions. Return ONLY valid JSON:
            {{
                "classes": ["ClassName"],
                "functions": ["func_name"]
            }}
            Code:
            {code}
            """
        );

        return std.json_loads(json_str);
    }
}
