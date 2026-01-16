# Source in ~/.zshrc
```
echo "source <Path to dotfiles>/zsh/python/functions.zsh" >> ~/.zprofile (or .zsh etc)
```

# Create Python virtual environment
```
create_python_env
```

Creates a `.venv` directory in the current folder using `python3 -m venv`.

If `.venv` already exists, the function will warn you and exit without making changes.

# Activate Python virtual environment
```
activate_python_env
```

Activates the `.venv` virtual environment in the current directory.

If no virtual environment exists, the function will display an error with instructions to create one first.

## Typical workflow
```
# In your project directory
create_python_env
activate_python_env
pip install -r requirements.txt
```
