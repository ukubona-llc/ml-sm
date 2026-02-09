#!/bin/bash

# Script to generate template and preliminary content for Amanda Ategeka, MD's Clinical Biostatistics and ML Tutorial
# This creates a directory structure similar to the aeronautical-maths project, with sessions focused on biostatistics, regression, simulation, etc.
# Assumes running in an empty directory or one where these files/folders don't conflict.

# Create main directories
mkdir -p sessions/css
mkdir -p sessions/html
mkdir -p sessions/js
mkdir -p sessions/sh
mkdir -p sessions/level2

# Create level2 sub-sessions (placeholders for advanced content)
for i in {1..8}; do
  mkdir -p sessions/level2/session$i
done

# Create root files
touch index.html
touch o.sh  # Placeholder for any operational script
touch llm_snapshot.log  # Placeholder log file

# Populate index.html with preliminary content adapted for Amanda's topics
cat << EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ukubona LLC: Level 1 - Clinical Biostatistics Internship</title>
    <link rel="stylesheet" href="sessions/css/index.css">
    <script src="sessions/js/index.js"></script>
</head>
<body>
    <h1>Ukubona LLC: Level 1 - Clinical Biostatistics Internship</h1>
    <h2>Learning Clinical Machine Learning & Systems Modeling</h2>
    <p>The self-taught approach: Biostatistics, regression, simulation, and machine learning are a solid foundation for clinical contexts.</p>
    <p>Ukubona LLC - 2026</p>

    <h2>Welcome</h2>
    <p>This 8-session program is designed to build a foundation in biostatistics and machine learning for clinical applications through modeling and simulation. It is self-paced, with optional Zoom guidance. Focus areas include biostatistics, regression models, simulations for clinical scenarios, and understanding ML generalization in medicine.</p>
    <p>Start with Session 0 to set up your Python environment. Activate venv for each session.</p>
    <p>Completion prepares you for Level 2: Advanced Clinical ML Challenges.</p>

    <h2>Clinical ML Career Guidance</h2>
    <p>Guidance from Amanda Ategeka, MD: Focus on roles in clinical data analysis, predictive modeling, and AI in healthcare.</p>
    <ul>
        <li>Operational Roles: Data Analyst in Hospitals</li>
        <li>Creative Roles: ML Engineer in Pharma or Research</li>
    </ul>

    <p>Access sessions via the app grid or links below.</p>
    <!-- Add links to sessions/html/sessionX.html as needed -->
</body>
</html>
EOF

# Create CSS file with basic styles
cat << EOF > sessions/css/index.css
body {
    font-family: Arial, sans-serif;
    margin: 20px;
    background-color: #f9f9f9;
}
h1, h2 {
    color: #333;
}
EOF

# Create JS file with basic script (placeholder)
cat << EOF > sessions/js/index.js
console.log("Clinical Biostatistics Internship loaded");
EOF

# Create session HTML files with preliminary content
for i in {0..8}; do
  touch sessions/html/session$i.html
  cat << EOF > sessions/html/session$i.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Session $i: Preliminary Content</title>
    <link rel="stylesheet" href="../css/index.css">
</head>
<body>
    <h1>Session $i</h1>
EOF

  # Add session-specific preliminary content
  case $i in
    0)
      echo "<p>Setup: Install Python, create venv, install packages like numpy, pandas, scipy, statsmodels.</p>" >> sessions/html/session$i.html
      ;;
    1)
      echo "<p>Intro to Biostatistics: Descriptive statistics, data visualization with matplotlib.</p>" >> sessions/html/session$i.html
      ;;
    2)
      echo "<p>Probability and Distributions: Normal, binomial, etc., simulations with numpy.</p>" >> sessions/html/session$i.html
      ;;
    3)
      echo "<p>Hypothesis Testing: t-tests, chi-square, p-values.</p>" >> sessions/html/session$i.html
      ;;
    4)
      echo "<p>Linear Regression: Simple and multiple regression using statsmodels.</p>" >> sessions/html/session$i.html
      ;;
    5)
      echo "<p>Logistic Regression: For binary outcomes in clinical data.</p>" >> sessions/html/session$i.html
      ;;
    6)
      echo "<p>Simulation Techniques: Monte Carlo simulations for uncertainty in models.</p>" >> sessions/html/session$i.html
      ;;
    7)
      echo "<p>Intro to ML: Supervised learning, scikit-learn basics.</p>" >> sessions/html/session$i.html
      ;;
    8)
      echo "<p>Model Evaluation: Generalization, overfitting, failure modes in clinical contexts.</p>" >> sessions/html/session$i.html
      ;;
  esac

  echo "</body></html>" >> sessions/html/session$i.html
done

# Create shell scripts in sessions/sh
touch sessions/sh/levels.sh
cat << EOF > sessions/sh/levels.sh
#!/bin/bash
# Script to setup level2 directories (already created)
echo "Level 2 sessions placeholders created."
EOF

touch sessions/sh/run.sh
cat << EOF > sessions/sh/run.sh
#!/bin/bash
# Placeholder run script
echo "Running clinical biostatistics tutorial setup."
EOF

touch sessions/sh/snap.sh
cat << EOF > sessions/sh/snap.sh
#!/bin/bash
# Generate project snapshot
echo "=========================================="
echo "📦 LLM PROJECT SNAPSHOT"
echo "=========================================="
echo "Directory: ."
echo "Generated: \$(date)"
echo "=========================================="

# Simple file count (adapt as needed)
echo "## 📊 SUMMARY"
files=\$(find . -type f | wc -l)
folders=\$(find . -type d | wc -l)
echo "Files   : \$files"
echo "Folders : \$folders"

# Add more sections as in the example
echo "## 🧾 FILE TYPES"
# ... (implement counting if needed)

echo "## 🌳 DIRECTORY TREE (Depth 3)"
tree -L 3
EOF

# Make shell scripts executable
chmod +x sessions/sh/*.sh
chmod +x o.sh  # If needed

echo "Template generated for Amanda Ategeka, MD's Clinical Biostatistics Internship."