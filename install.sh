#!/bin/sh

DOTFILES_ROOT="`pwd`"

link_files () {
  ln -s $1 $2
  echo "--> Creating symbolic link to $2 at $1"
}

# Create backup directory if doesn't exist
if [ ! -e $target ]; then
  mkdir $HOME/.dotfiles-backup
fi

# Determine which topics to load
if [ -e $DOTFILES_ROOT/topics/custom ]; then
  TOPICS_FILE=$DOTFILES_ROOT/topics/custom
else
  TOPICS_FILE=$DOTFILES_ROOT/topics/full
fi

echo "Loading topics from $TOPICS_FILE"

# Install the topics
while read topic; do
  echo "Installing topic $topic"
  for source in `find $DOTFILES_ROOT/$topic -name \*.symlink`
  do
    echo "-> Linking $source"

    target="$HOME/.`basename \"${source%.*}\"`"
    backup="$HOME/.dotfiles-backup/`basename \"${source%.*}\"`.backup"

    if [ -L $target ] && [ `readlink $target` = $source ]; then
     echo "--> Symbolic link to $source already exists at $target"
    elif [ -e $target ]; then
      echo "--> Backing up existing $target to $backup"
      if [ -e $backup ]; then
        echo "--> Backup already exists, will not overwrite. Remove with `rm $backup`, then run again."
      else
        mv $target $backup
        link_files $source $target
      fi
    else
      link_files $source $target
    fi
  done
done < $TOPICS_FILE

echo "Done!"
