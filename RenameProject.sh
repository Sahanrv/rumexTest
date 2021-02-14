# Changing Project name

# install the necessary package
brew install rename ack

# run this for a couple of times
find . -name 'RumexMovie*' -print0 | xargs -0 rename -S 'RumexMovie' 'RumexMovie'

ack --literal --files-with-matches 'RumexMovie' | xargs sed -i '' 's/RumexMovie/RumexMovie/g'

# double confirm, if no output, that means success
ack --literal 'RumexMovie'
