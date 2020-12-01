# Organisir

A Ruby gem made to organise large number of files effectively using a simple set of predfined rules and checks based on filenames. Currently the rules are hardcoded based on my personal preferences although I am planning to implement a custom rule injection to allow others with working knowledge of ruby to write their own rules for file management.

## Installation

Run this command to install organisir

```{shell}
gem install organisir
```

## Usage

In its current state, organisir supports two types of file organisation.

### 1. Moving files inside a source directory(S) to a destination directory(D)

Suppose your directory S has a lot of files and your D directory has multiple sub-directories with names d1, d2,...,dn. Each file inside S contains the word(s) d1..dn inside them. Organisir can scan each of these files in S and move them inside the subdirectories inside D. If a filename contains multiple combinations of d1..dn, the first match is selected for moving the file.

#### Example

Source directory is `~/Images`
Destination directory is `~/Images/Organised`

Your files inside `Images` directory contains the year in their file names eg. `IMG_01_JAN_2018.jpg` and your destination directory has multiple directories with year name eg. `~/Images/Organised/2017, ~/Images/Organised/2018, ~/Images/Organised/2019` and so on.

To move all files inside the `Images` directory to the sub-directories inside `Images/Organised` directory, you can invoke the following command.

```{shell}
cd ~
organisir start --source Images --destination Images/Organised
```

By default, organisir never modifies any files unless specified explicitly. Running the command will give you a full result of the files which matched the rule and the chosen directory for moving. You can review the output and if it looks good, pass an additional `--commit true` flag to the earlier command.

```{shell}
cd ~
organisir start --source Images --destination Images/Organised --commit true
```

### 2. Creating references to a file in multiple directories inside a parent directory(P)

This command is useful if you have files inside directory which may also required to be present in other directories based on their filenames. It usually extends on the first scenario.

#### Example

Parent directory is `~/Images/Organised`

Your parent directory may contain multiple sub-directories with some names `d1,d2,..,dn` etc. If you have files in any of these sub-directory which may fulfill the filename rule matching criteria, the symlink command can create symlinks of the original files inside each sub-directory which matches the filename rule match.

```{shell}
cd ~
organisir symlink --source Images/Organised
```

Again by default, organisir never modifies any files unless specified explicitly. Running the command will give you a full list of matches found. You can review the output and if it looks good, pass an additional `--commit true` flag to the earlier command.

```{shell}
cd ~
organisir symlink --source Images/Organised --commit true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/organisir.

## TODO

- [ ] Provide support for users to write their own ruby code to allow custom matching rules.

- [ ] Allow symlink command to work with a source and destination directory rather than a single source diirectory.
