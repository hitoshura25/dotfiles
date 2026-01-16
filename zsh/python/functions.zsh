create_python_env() {
  python3 -m venv .venv
}

activate_python_env() {
  source .venv/bin/activate
}