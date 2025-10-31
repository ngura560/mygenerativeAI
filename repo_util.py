import os
import git
import traceback

def clone_repo(repo_url: str):
    """
    Clone a GitHub repository to a local folder named after the repo.
    Returns the local path if successful, or {'error': message} on failure.
    """
    try:
        repo_name = repo_url.rstrip("/").split("/")[-1].replace(".git", "")
        local_path = os.path.join(os.getcwd(), repo_name)

        if os.path.exists(local_path):
            print(f" Repository already exists locally at: {local_path}")
            return local_path

        print(f" Cloning repository from {repo_url}...")
        git.Repo.clone_from(repo_url, local_path)
        print(f" Successfully cloned to {local_path}")
        return local_path

    except Exception as e:
        print(" Error cloning repository:", e)
        traceback.print_exc()
        return {"error": str(e)}


def generate_file_tree(repo_path: str):
    """
    Generate a dictionary representing the directory and file structure of a repo.
    Example output:
    {
        "src": {"files": ["main.py", "utils.py"]},
        "data": {"files": ["dataset.csv"]}
    }
    """
    file_tree = {}
    for root, dirs, files in os.walk(repo_path):
        # Skip hidden folders (e.g., .git)
        if any(part.startswith('.') for part in root.split(os.sep)):
            continue

        relative_dir = os.path.relpath(root, repo_path)
        if relative_dir == ".":
            relative_dir = "."

        file_tree[relative_dir] = {"files": files}
    return file_tree


def read_readme(repo_path: str):
    """
    Read the repository's README file if it exists (supports .md, .txt).
    """
    for readme_name in ["README.md", "README.txt", "readme.md", "readme.txt"]:
        readme_path = os.path.join(repo_path, readme_name)
        if os.path.exists(readme_path):
            try:
                with open(readme_path, "r", encoding="utf-8") as f:
                    return f.read().strip()
            except Exception as e:
                return f"⚠️ Error reading {readme_name}: {e}"

    return " No README file found in the repository."
