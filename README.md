# Orthanc DICOM server for caMicroscope

Builds Docker images for orthanc.

```
docker run -i -t -p 8042:8042 orthanc
```

`-i -t` required [to be able to stop the container](https://stackoverflow.com/a/41099052)

## Testing

See the storescu command on https://book.orthanc-server.com/users/cookbook.html

## Configuration file

As https://book.orthanc-server.com/users/configuration.html#configuration notes, Orthanc --config=Configuration.json` can be used to show all default values. Or, see https://hg.orthanc-server.com/orthanc/file/Orthanc-1.12.1/OrthancServer/Resources/Configuration.json