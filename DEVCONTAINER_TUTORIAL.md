# Running This Repository with Dev Containers

This guide will help you get started with this repository using Visual Studio Code Dev Containers.

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Steps

1. **Clone the Repository**

   ```bash
   git clone <this-repo-url>
   cd <repo-folder>
   ```

2. **Open in VS Code**

   - Launch VS Code.
   - Open the folder you just cloned.

3. **Open in Dev Container**

   - Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac).
   - Type and select: `Dev Containers: Open Folder in Container...`
   - Select the current folder.

4. **Wait for the Container to Build**

   - VS Code will build and start the development container using the configuration in the `/.devcontainer/` directory.
   - This may take a few minutes the first time.

5. **Start Working**
   - Once the container is ready, you can use the integrated terminal and all pre-installed tools.
   - No extra setup is needed on your local machine.

## More Information

- See the `.devcontainer/` directory for configuration details.
- Learn more about Dev Containers: [Overview](https://containers.dev)
