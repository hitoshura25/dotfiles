create_python_env() {
  if [ -d ".venv" ]; then
    echo "⚠️  .venv already exists in current directory"
    echo "   Remove it first with: rm -rf .venv"
    return 1
  fi
  python3 -m venv .venv && echo "✅ Created virtual environment in .venv"
}

activate_python_env() {
  if [ ! -f ".venv/bin/activate" ]; then
    echo "❌ No virtual environment found at .venv/bin/activate"
    echo "   Create one first with: create_python_env"
    return 1
  fi
  source .venv/bin/activate && echo "✅ Activated virtual environment"
}