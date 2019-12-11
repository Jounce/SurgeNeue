# Generate derived implementation from blueprints:

packages=(
    "SurgeArithmetic"
)

for package in ${packages[@]}; do
     echo ""
     echo "🌀 Generating derived implementations for ${package}..."
     echo ""

     sourcery \
        --sources "./Sources/${package}/" \
        --output "./Sources/${package}/Generated/" \
        --templates "./Templates/Derive.swifttemplate" \
        --verbose
    
    echo ""
    echo "🌀 Generating derived tests for ${package}..."
    echo ""

    sourcery \
        --sources "./Sources/${package}/" \
        --output "./Tests/${package}Tests/Generated/" \
        --templates "./Templates/DeriveTests.swifttemplate" \
        --args "framework=${package}" \
        --verbose
done
