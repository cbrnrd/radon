<p align="center"><img src="https://raw.githubusercontent.com/cbrnrd/radon/master/img/radon-readme-header.png"></p>
<p align="center"><img src="https://raw.githubusercontent.com/cbrnrd/radon/master/img/demo.gif"></p>

## Installation

`radon` is part of the [periodic](https://periodic.now.sh) collection of apps. If you install `periodic-cli`, radon should come with it:

    $ gem install periodic-cli

Or install just the gem:

    $ gem install radon

## Usage

The basic usage is as follows: `radon [environment] {ProjectName}`.

A full list of supported environments can be found by running `radon --list-env`

#### Example:

Here is radon generating a gradle project called MyGradleProject
```
$ radon gradle MyGradleProject
Creating project under /mnt/c/Users/Carter/Desktop/projects/MyGradleProject
  create MyGradleProject
  create MyGradleProject/.gradle/
  create MyGradleProject/.gradle/4.5/
  create MyGradleProject/.gradle/4.5/fileChanges/
  create MyGradleProject/.gradle/4.5/fileChanges/last-build.bin
  create MyGradleProject/.gradle/4.5/fileHashes/
  create MyGradleProject/.gradle/4.5/fileHashes/fileHashes.bin
  create MyGradleProject/.gradle/4.5/fileHashes/fileHashes.lock
  create MyGradleProject/.gradle/4.5/taskHistory/
  create MyGradleProject/.gradle/4.5/taskHistory/taskHistory.bin
  create MyGradleProject/.gradle/4.5/taskHistory/taskHistory.lock
  create MyGradleProject/.gradle/buildOutputCleanup/
  create MyGradleProject/.gradle/buildOutputCleanup/buildOutputCleanup.lock
  create MyGradleProject/.gradle/buildOutputCleanup/cache.properties
  create MyGradleProject/.gradle/buildOutputCleanup/outputFiles.bin
  create MyGradleProject/build.gradle
  create MyGradleProject/gradle/
  create MyGradleProject/gradle/wrapper/
  create MyGradleProject/gradle/wrapper/gradle-wrapper.jar
  create MyGradleProject/gradle/wrapper/gradle-wrapper.properties
  create MyGradleProject/gradlew
  create MyGradleProject/gradlew.bat
  create MyGradleProject/settings.gradle
  create MyGradleProject/src/
  create MyGradleProject/src/main/
  create MyGradleProject/src/main/java/
  create MyGradleProject/src/main/test/
Done! Your project is set up in /mnt/c/Users/Carter/Desktop/projects/MyGradleProject.
```

## Development

#### Adding an environment
If you want to add an environment to radon, here are the steps:
1. Create the standard directory structure of that environment. This is usually found on the environment's website or just through convention.
2. Zip all the files into one file (`zip -r env.zip .`)
3. Save the zip data as base64 (`cat env.zip | base64 -w 0 > env.b64`)
4. Put both the base64 data and the zip file in radon's `/data` folder.
5. Add the function(s) in `extract.rb` to extract the _zip_ file to the target (See [here](https://github.com/cbrnrd/radon/blob/7cd141b5a61de6a8abaf0009a1a8cfd090f05e97/lib/core/extract.rb#L5))
6. Add the environments to `@@all` in `environments.rb`
7. Open a pull request

If the environment requires a project name (eg. ruby class name or file-names) you can put these token identifiers to be replaced during project creation:

| Identifier        | Meaning           |
| :-------------: |:-------------:|
| `{{NAME}}`      | The dash-seperated project name (eg. `my-cool-project`) |
| `{{CAPSNAME}}`      | The capitalized project name (eg. `MyCoolProject`) |
| `{{EMAIL}}` | The email of the user |
| `{{GHNAME}}` | The GitHub username of the user |


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cbrnrd/radon. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Radon project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/cbrnrd/radon/blob/master/CODE_OF_CONDUCT.md).
