import os
import re

def main(replace_target, replace_with, append_text):
    # Get the directory of the script
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Iterate over all *.gjf files
    for filename in os.listdir(script_dir):
        if filename.endswith('.gjf'):
            with open(filename, 'r+') as f:
                content = f.read()
                
                # Perform user-specified substitution
                content = re.sub(replace_target, replace_with, content)
                
                # Update the file
                f.seek(0)
                f.write(content)
                f.write(append_text)

if __name__ == "__main__":
    replace_target = input("Enter the text to be replaced: ")
    replace_with = input("Enter the text to replace with: ")
    append_text = input("Enter the text to append at the end: ")
    main(replace_target, replace_with, append_text)