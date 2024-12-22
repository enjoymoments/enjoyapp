# mozin

- Flutter version: 2.10.5


## For authentication with Google

- https://coderwall.com/p/r09hoq/android-generate-release-debug-keystores
- https://stackoverflow.com/questions/54557479/flutter-and-google-sign-in-plugin-platformexceptionsign-in-failed-com-google

## Route

```yaml
$ flutter packages pub run build_runner build
```

## Produtivity

```yaml
$ chmod +x gca.sh
```

```yaml
$ ./gca.sh hello mozin
```

## Build Release
```yaml
flutter clean && flutter build apk --release
```

## Generate icon
```yaml
flutter pub run flutter_launcher_icons:main
```