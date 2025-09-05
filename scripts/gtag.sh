gtag() {
   # Fetch all tags from remote
   echo "Fetching tags from remote..."
   git fetch --tags >/dev/null 2>&1

   current_tag=$(git describe --abbrev=0 --tags 2>/dev/null)
   if [ -z "$current_tag" ]; then
       echo "No tags found in the repository."
       printf "Enter the initial tag name: "
       read new_tag
       if [[ -z "$new_tag" ]]; then
           echo "Tag name cannot be empty."
           gtag
           return
       fi
   else
       echo "Current tag: $current_tag"
       printf "Do you want to create a new tag based on this? (y/n): "
       read choice
       if [[ "$choice" == "n" || "$choice" == "N" ]]; then
           echo "No new tag created."
           return 0
       fi

       # Determine default new tag by bumping the patch version
       default_tag=""
       if [[ "$current_tag" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
           prefix="v"
           version_str="${current_tag#v}"
       elif [[ "$current_tag" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
           prefix=""
           version_str="$current_tag"
       else
           version_str=""
       fi

       if [[ -n "$version_str" ]]; then
           IFS='.' read -r major minor patch <<< "$version_str"
           if [[ "$patch" =~ ^[0-9]+$ ]]; then
               next_patch=$((patch + 1))
               default_tag="${prefix}${major}.${minor}.${next_patch}"
           fi
       fi

       # Prompt for new tag name
       if [[ -n "$default_tag" ]]; then
           printf "Enter the new tag name (%s): " "$default_tag"
           read new_tag
           if [[ -z "$new_tag" ]]; then
               new_tag="$default_tag"
           fi
       else
           printf "Enter the new tag name: "
           read new_tag
       fi

       if [[ -z "$new_tag" ]]; then
           echo "Tag name cannot be empty."
           gtag
           return
       fi
   fi

   # Check if tag already exists and increment if needed
   original_tag="$new_tag"
   
   while git rev-parse --verify "refs/tags/$new_tag" >/dev/null 2>&1; do
       if [[ "$new_tag" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
           # Handle semantic versioning format
           prefix="v"
           version_str="${new_tag#v}"
           IFS='.' read -r major minor patch <<< "$version_str"
           new_tag="v${major}.${minor}.$((patch + 1))"
       elif [[ "$new_tag" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
           # Handle version without v prefix
           IFS='.' read -r major minor patch <<< "$new_tag"
           new_tag="${major}.${minor}.$((patch + 1))"
       else
           # For non-semantic tags, append incrementing number
           if [[ "$new_tag" =~ ^(.+)-([0-9]+)$ ]]; then
               base="${BASH_REMATCH[1]}"
               num="${BASH_REMATCH[2]}"
               new_tag="${base}-$((num + 1))"
           else
               new_tag="${new_tag}-1"
           fi
       fi
   done

   if [[ "$new_tag" != "$original_tag" ]]; then
       echo "Tag '$original_tag' exists. Using '$new_tag' instead."
   fi

   # Create tag
   if ! git tag "$new_tag"; then
       echo "Failed to create tag. Check repository status and try again."
       gtag
       return
   fi

   # Push tag with retry logic
   push_tag() {
       if git push origin "$new_tag" 2>/dev/null; then
           echo "New tag '$new_tag' created and pushed."
           return 0
       else
           echo "Failed to push tag '$new_tag'."
           printf "Retry push? (y/n): "
           read retry_choice
           if [[ "$retry_choice" == "n" || "$retry_choice" == "N" ]]; then
               echo "Tag '$new_tag' created locally but not pushed."
           else
               push_tag
           fi
       fi
   }

   push_tag
}
